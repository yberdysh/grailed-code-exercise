# spec/models/user_spec.rb
require_relative "../app/models/User.rb"
require_relative "../app/models/DisallowedUsername.rb"
require 'active_record'
# require_relative "spec_helper"

# Prefix class methods with a '.'
describe User, '.find_users_with_disallowed' do
  it 'returns only users with disallowed usernames' do
    # setup
    # active_user = create(:user, active: true)
    # non_active_user = create(:user, active: false)

    # exercise
    result = User.find_users_with_disallowed
    user1 = User.find(2400)
    user2 = User.find(2448)
    user3 = User.find(3206)
    user4 = User.find(4512)
    user5 = User.find(5580)

    # verify
    # expect(result).to eq [active_user]
    expect(result).to include(user1)

    # teardown is handled for you by RSpec
  end
end

# Prefix instance methods with a '#'
# describe User, '#name' do
#   it 'returns the concatenated first and last name' do
#     # setup
#     user = build(:user, first_name: 'Josh', last_name: 'Steiner')

#     # excercise and verify
#     expect(user.name).to eq 'Josh Steiner'
#   end
# end
