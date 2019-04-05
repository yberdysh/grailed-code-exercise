require 'set'

class User < ActiveRecord::Base

  def self.resolve_collisions(dry_run = nil)
    unique_usernames = Set.new
    affected_rows = []
    self.all.each do |user|
      if !unique_usernames.include?(user.username)
        unique_usernames.add(user.username)
      else
        core_name = user.username
        num = 1
        while unique_usernames.include?("#{core_name}#{num}")
          num += 1
        end
        # reassign username here
        user.username = "#{core_name}#{num}"
        affected_rows << user
        unique_usernames.add("#{core_name}#{num}")
      end
    end
    affected_rows
  end

  # to do another way:
  #   my_string = 'potato8585'
  # my_string.scan( /\d+$/ ).first

  # Write a function that resolves all username collisions. E.g., two users with the username `foo` should become `foo` and `foo1`. The function accepts an optional "dry run" argument that will print the affected rows to the console, not commit the changes to the db.
end
