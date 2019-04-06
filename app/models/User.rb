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
      new_name = user.resolve_collision
      user.username = new_name
      affected_rows << user
      UNIQUE_USERNAMES.add(new_name)
    end
  end

  def self.resolve_collisions(dry_run = nil)
    affected_rows = []
    self.all.each do |user|
      if !UNIQUE_USERNAMES.include?(user.username)
        UNIQUE_USERNAMES.add(user.username)
      else
        new_name = user.resolve_collision
        user.username = new_name
        affected_rows << user
        UNIQUE_USERNAMES.add(new_name)
      end
    end
    affected_rows
  end

  def resolve_collision
    username = self.username
    nums = username.scan( /\d+$/ ).first || "1"
    nums_len = nums.length
    core_name = username.last =~ /\D/ ? username : username[0...nums_len*-1]
    num = nums.to_i == 0 ? nums.to_i + 1 : nums.to_i
    while UNIQUE_USERNAMES.include?("#{core_name}#{num}")
      num += 1
    end
    new_name = "#{core_name}#{num.to_s}"
  end

  def check_if_disallowed
    DisallowedUsername.disallowed_usernames.include?(self.username.downcase)
  end
end
