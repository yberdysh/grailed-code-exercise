require 'set'

class User < ActiveRecord::Base
  UNIQUE_USERNAMES = Set.new
  # using set to improve time complexity since sets have direct lookup

  def self.find_users_with_disallowed
    User.all.select{|user| user.check_if_disallowed}
  end

  def self.resolve_disallowed(dry_run = nil)
    affected_rows = []
    names_to_fix = self.find_users_with_disallowed
    names_to_fix.each do |user|
      user.handle_found_collision(dry_run)
      affected_rows << user
    end
    return affected_rows if dry_run
  end

  def self.resolve_collisions(dry_run = nil)
    affected_rows = []
    self.all.each do |user|
      if !UNIQUE_USERNAMES.include?(user.username)
        UNIQUE_USERNAMES.add(user.username)
      else
        user.handle_found_collision(dry_run)
        affected_rows << user
      end
    end
    return affected_rows if dry_run
  end


  def handle_found_collision(dry_run = nil)
    new_name = self.resolve_collision
    self.username = new_name
    self.save if !dry_run
    UNIQUE_USERNAMES.add(new_name)
  end

  def resolve_collision
    username = self.username
    nums = username.scan( /\d+$/ ).first || "0"
    nums_len = nums.length
    core_name = username[-1] =~ /\D/ ? username : username[0...nums_len*-1]
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
