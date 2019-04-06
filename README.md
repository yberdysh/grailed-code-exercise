# Engineering Backend Exercise


## Approach

_I considered using Ruby on Rails because I saw that the premise of this exercise had to do with providing pretty URL 
routes to users, and I considered building out an API that handles fetching user instances and creating new user instances. 
However, I decided against using Rails because it would provide too much extra functionality that isn't needed. My take on this
exercise is that we need a simple tool to tidy the database, so I created some scripts that automate this. Even though I am more 
comfortable in JavaScript, I decided to use Ruby and ActiveRecord for this exercise because I realize that the back-end stack at 
Grailed & Heroine will be RoR._

## Installation Instructions  ⤵

- `git clone` 
- `cd grailed-code-exercise`
- `bundle` 

## Cleaning the Database using CLI  ⤵
The database with all of the usernames is already connected in the db folder. If you'd like to use the command-line interface to clean the database, be sure to run:
- `ruby bin/run.rb` 

The CLI provides the following options, and you can type 1, 2, 3, or 4 followed by `enter` to choose the option.

<img src="https://snag.gy/dw4j6u.jpg" alt="cli-image" width="650" height="300">

**Option 1** will print all user instances with disallowed usernames.  


**Option 2** will do a "dry run" to resolve all disallowed and duplicate usernames. It will print the user instances that are impacted with the new names that they will receive, but it will not save to the database.


**Option 3** is no longer a dry run. It will resolve all disallowed and duplicate usernames, saving the changes to the database. It will not print the impacted rows, but it will show how many rows were impacted by the changes.

_Note: If you'd like to undo the changes caused by Option 3, you would have to delete the database file `grailed-exercise.sqlite3` and replace it with the original database file with the same name._

Example output: 

<img src="https://snag.gy/0Ud3LH.jpg" alt="cli-image" width="650" height="500">

## Cleaning the Database using Rake Console  ⤵
If you would like to have even more control than the automated options provided by the `bin/run.rb` file, I have created a 
`rake` task that allows you to go into the console. Simply use the command: 
- `rake console`

From there, you are welcome to use any ActiveRecord methods such as `User.all` or any class or instance methods that I've provided in the User model. Feel free to try `User.find_users_with_disallowed` to get the user instance with disallowed usernames:

<img src="https://snag.gy/a6gzWh.jpg" alt="cli-image" width="650" height="500">

Some other methods you can try: 
- `User.resolve_disallowed` to rename disallowed users
- `User.resolve_collisions` to rename users to unique usernames

_Note: If you are using these methods direcly through the `rake console`, you will need to pass `true` or `"dry run"` to these methods if you would like a dry run, otherwise changes will persist to the database._

## Running Tests  ⤵
I have manually tested the methods for a variety of inputs as well as written some test specs on some edge cases to make sure that the methods work. The test specs can be found in `spec/user_spec.rb`. The command to run the specs is: 
- `rspec`


This was my first time writing test specs in Ruby, so I apologize if anything was amiss. Most of the spec_helper file was taken from an example that I found, but the `user_spec.rb` file was written by me.

## Thank you!

Thank you for the opportunity to complete this assignment! I truly enjoy this kind of back-end work and I appreciated getting a real-world problem to solve. If there is anything I misunderstood about this challenge or anything you'd like me to add, I would be happy to make changes to this repo. 

