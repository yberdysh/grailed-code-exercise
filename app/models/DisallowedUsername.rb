class DisallowedUsername < ActiveRecord::Base

  def self.disallowed_usernames
    self.all.map{|username| username.invalid_username}
  end

end
