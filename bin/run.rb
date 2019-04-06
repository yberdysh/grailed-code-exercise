require_relative "../config/environment"

def give_options
  puts "========================="
  puts "What would you like to do?"
  puts "1. View users with disallowed usernames"
  puts "2. Resolve disallowed and duplicate usernames with dry run"
  puts "3. Resolve disallowed and duplicate usernames"
  puts "4. Exit"
end

def get_user_input
  input = gets.chomp
end

def run_script
  give_options
  input = get_user_input
  while input != "4"
    case input
    when "1"
      puts users_with_disallowed
      give_options
      input = get_user_input
    when "2"
      option2
      give_options
      input = get_user_input
    when "3"
      option3
      give_options
      input = get_user_input
    end
  end
  puts "GOODBYE!"
end

def option2
  results = resolve_disallowed_and_duplicates(true)
  puts "Users impacted with disallowed usernames:"
  puts results.first
  puts "========================="
  puts "Users impacted with duplicate usernames:"
  puts results.second
  puts "DONE"
end

def option3
  results = resolve_disallowed_and_duplicates(false)
  num_impacted = results[0].length + results[1].length
  puts "DONE"
  puts "#{num_impacted} rows impacted"
end

def resolve_disallowed_and_duplicates(dry_run)
  all_disallowed = User.resolve_disallowed(dry_run)
  all_duplicates = User.resolve_collisions(dry_run)
  all_disallowed_formatted = all_disallowed.map{|user| {id: user.id, username: user.username}}
  all_duplicates_formatted = all_duplicates.map{|user| {id: user.id, username: user.username}}
  return [all_disallowed_formatted, all_duplicates_formatted]
end

def users_with_disallowed
  disallowed_users = User.find_users_with_disallowed
  formatted = disallowed_users.map{|user| {id: user.id, username: user.username}}
end

run_script
