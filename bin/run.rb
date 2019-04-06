require_relative "../config/environment"

def give_options
  puts "========================="
  puts "What would you like to do?"
  puts "1. Resolve disallowed and duplicate usernames"
  puts "2. Resolve disallowed and duplicate usernames with dry run"
  puts "3. View users with disallowed usernames"
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
      results = resolve_disallowed_and_duplicates(false)
      num_impacted = results[0].length + results[1].length
      puts "DONE"
      puts "#{num_impacted} rows impacted"
      give_options
      input = get_user_input
    when "2"
      results = resolve_disallowed_and_duplicates(true)
      puts "Users impacted with disallowed usernames:"
      puts results[0]
      puts "Users impacted with duplicate usernames:"
      puts results[1]
      puts "DONE"
      give_options
      input = get_user_input
    when "3"
      puts "hello 3"
      give_options
      input = get_user_input
    end
  end
end

def resolve_disallowed_and_duplicates(dry_run)
  all_disallowed = User.resolve_disallowed(dry_run)
  all_duplicates = User.resolve_collisions(dry_run)
  all_disallowed = all_disallowed.map{|user| {id: user.id, username: user.username}}
  all_duplicates = all_duplicates.map{|user| {id: user.id, username: user.username}}
  return [all_disallowed, all_duplicates]
end

run_script
# puts  "What is your Pokemon's name?"
# pokemon_name = gets.chomp

# puts "What is your Pokemon's move?"
# pokemon_attack = gets.chomp


# pokemon = Pokemon.create(
#   name: pokemon_name,
#   attack: pokemon_attack
# )

# puts "Here is your Pokemon, #{pokemon.name}"

# puts "-------------------------------"
# puts ""

# puts "Here are all of the Pokemon we have made:"

# Pokemon.all.each do |pokemon|
#   puts "#{pokemon.name}"
#   puts "oh no..#{pokemon.attack}"
# end
