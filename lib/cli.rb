class CLI

  def run
    puts ""
    puts "Welcome to Solo Jeopardy"
    puts ""
    sleep(1)
    puts "Loading your categories, please wait."
    puts ""
    Fetcher.fetch_six_categories
    puts "Done!"
    puts ""
    sleep(1)
    puts "Here are the categories I came up with:"
    puts ""
    sleep(1)
    puts "#{Category.all[0].name}   |   #{Category.all[1].name}   |   #{Category.all[2].name}   |   #{Category.all[3].name}   |   #{Category.all[4].name}   |   #{Category.all[5].name}"
    puts ""
    sleep(1)
    puts "Would you like to play a game with these categories? (Y/N)"
    puts ""
    user_input = gets.chomp.capitalize
    sleep(0.3)
    if user_input == "Y"
      # continue with game
    elsif user_input == "N"
      # get new set of categories
      Fetcher.fetch_six_categories
    else
      puts ""
      puts "Sorry, you need to enter:"
      puts ""
      sleep(1)
      puts "Y for 'yes'    or    N for 'no'"
      puts ""
      puts ""
      puts ""
      sleep(2)
      puts "#{Category.all[0].name}   |   #{Category.all[1].name}   |   #{Category.all[2].name}   |   #{Category.all[3].name}   |   #{Category.all[4].name}   |   #{Category.all[5].name}"
      puts ""
      sleep(1)
      puts "Would you like to play a game with these categories? (Y/N)"
      puts ""
    end
      

  end
end


def start_game?
end
