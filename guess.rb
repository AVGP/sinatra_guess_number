require 'sinatra'

# This will create a cookie in the browser of our user where we can store things
enable :sessions

# Our start page
get '/' do
  # If we haven't stored a number to guess for our user, we will do so now
  if session["number_to_guess"].nil?
    # Generate a random number between 1 and 10 and store it in the cookie
    session["number_to_guess"] = rand(1..10)
  end
  # show the contents of the file at views/index.erb and use an empty string for the "result" variable
  erb :index, locals: { result: "" }
end

# This is where the user ends up after clicking "Guess!"
post '/' do
  result = ""
  # Read the number that was entered into the input field and make it a number
  guessed_number = params["number"].to_i

  # Compare the number to the number we've stored in the cookie
  if guessed_number == session["number_to_guess"]
    # The game is won, so give the user a new number to guess
    session["number_to_guess"] = rand(1..10)

    result = "You win!"
  elsif guessed_number > session["number_to_guess"]
    result = "Too large"
  else
    result = "Too small"
  end

  # show the contents of the file at views/index.erb and use the result we've set
  erb :index, locals: { result: result }
end
