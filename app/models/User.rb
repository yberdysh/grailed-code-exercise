require 'set'

class User < ActiveRecord::Base
  UNIQUE_USERNAMES = Set.new
  # using constant that caches unique usernames and has direct lookup

  def self.find_users_with_disallowed
    User.all.select{|user| user.check_if_disallowed}
  end


  # resolve all disallowed usernames to make them allowed and unique
  def self.resolve_disallowed(dry_run = nil)
    affected_rows = []
    names_to_fix = self.find_users_with_disallowed
    names_to_fix.each do |user|
      user.handle_found_collision(dry_run)
      affected_rows << user
    end
    return affected_rows
  end


  def self.resolve_collisions(dry_run = nil)
    affected_rows = []
    self.all.each do |user|
      if !UNIQUE_USERNAMES.include?(user.username)
        UNIQUE_USERNAMES.add(user.username)
        # adds a newly seen unique username to the cache
      else
        # handles a collision if we find a name we've seen before
        user.handle_found_collision(dry_run)
        affected_rows << user
      end
    end
    return affected_rows
  end


  def handle_found_collision(dry_run = nil)
    # resolves collision, renames the user, adds their new username to cache
    new_name = self.resolve_collision
    self.username = new_name
    self.save if !dry_run
    UNIQUE_USERNAMES.add(new_name)
  end


  def resolve_collision
    # acts on the instance of user that needs to resolve a collision and returns a new unique name
    username = self.username
    nums = username.scan( /\d+$/ ).first || "0"
    # regex to get any nums at the end of the username
    nums_len = nums.length
    core_name = username[-1] =~ /\D/ ? username : username[0...nums_len*-1]
    # username after any trailing numbers are removed
    num = nums.to_i + 1
    while UNIQUE_USERNAMES.include?("#{core_name}#{num}")
      num += 1
    end
    "#{core_name}#{num.to_s}"
  end


  def check_if_disallowed
    DisallowedUsername.disallowed_usernames.include?(self.username.downcase)
  end
end
