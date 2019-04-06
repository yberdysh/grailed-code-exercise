# spec/models/user_spec.rb
require 'spec_helper'

# Prefix class methods with a '.'
describe User, '.find_users_with_disallowed' do
  it 'returns only users with disallowed usernames' do
    result = User.find_users_with_disallowed
    user1 = User.find(2400)
    user2 = User.find(2448)
    user3 = User.find(3206)
    user4 = User.find(4512)
    user5 = User.find(5580)
    # verify
    expect(result).to include(user1)
    expect(result).to include(user2)
    expect(result).to include(user3)
    expect(result).to include(user4)
    expect(result).to include(user5)
  end
end

describe User, '.resolve_disallowed' do
  it 'changes the disallowed usernames and returns impacted users' do
    result = User.resolve_disallowed(true)
    user1 = result.find{|user| user.id == 2400}
    user2 = result.find{|user| user.id == 3487}
    user3 = result.find{|user| user.id == 9807}
    user4 = result.find{|user| user.id == 8141}
    expect(user1).to have_attributes(username: "grailed1")
    expect(user2).to have_attributes(username: "about2")
    expect(user3).to have_attributes(username: "settings6")
    expect(user4).to have_attributes(username: "heroine3")
  end
end

describe User, '.resolve_collisions' do
  it 'changes the duplicate usernames and returns impacted users' do
    result = User.resolve_collisions(true)
    # rowena0 -> rowena1 id: 1045
    # lightning -> lightning1 id: 3264
    # adella9 -> adella10 id: 3304
    # demetris10 -> demetris12 id: 9513

    user1 = result.find{|user| user.id == 1045}
    user2 = result.find{|user| user.id == 3264}
    user3 = result.find{|user| user.id == 3304}
    user4 = result.find{|user| user.id == 9513}
    expect(user1).to have_attributes(username: "rowena1")
    expect(user2).to have_attributes(username: "lightning1")
    expect(user3).to have_attributes(username: "adella10")
    expect(user4).to have_attributes(username: "demetris11")
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
