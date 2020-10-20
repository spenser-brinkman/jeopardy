class CLI

  def run
    sleep(0)
    10.times {self.gap}
    puts "Welcome to Solo Jeopardy!".center(172)
    puts ""
    sleep(0)
    puts "Loading your categories, please wait.".center(172) 
    puts ""
    self.gather_categories
    self.prompt_for_input
    puts "Great! Please wait for your clues to load.".center(172)
    self.gap
    Fetcher.fetch_thirty_clues
    self.display_clues
    binding.pry
  end

  def gather_categories
    Category.all.clear
    Fetcher.fetch_six_categories
    puts "Done!".center(172)
    puts ""
    sleep(0)
  end

  def prompt_for_input
    loop do
      puts "Here are the categories I came up with:".center(172)
      puts ""
      sleep(0)
      puts "#{Category.all[0].name}   |   #{Category.all[1].name}   |   #{Category.all[2].name}   |   #{Category.all[3].name}   |   #{Category.all[4].name}   |   #{Category.all[5].name}".center(172)
      puts ""
      sleep(0)
      puts "Would you like to play a game with these categories? (Y/N)".center(172)
      puts ""
      user_input = gets.chomp.capitalize
      sleep(0.3)
      if user_input == "Y"
        puts ""
        sleep(0)
        break      
      elsif user_input == "N"
        puts ""
        sleep(0)
        puts "Loading a new set of categories, please wait.".center(172)
        puts ""
        self.gather_categories
      else
        sleep(0)
        puts ""
        puts "Sorry, you need to enter:".center(172)
        puts ""
        sleep(0)
        puts "Y for 'yes'    or    N for 'no'".center(172)
        self.gap
        binding.pry
        sleep(2)
      end
    end
  end



  def display_clues
    puts "#{Category.all[0].name}    ---    #{Category.all[0].clues.map {|clue| clue.point_value}.join(" | ")}".center(172)
    self.gap
    puts "#{Category.all[1].name}    ---    #{Category.all[1].clues.map {|clue| clue.point_value}.join(" | ")}".center(172)
    self.gap
    puts "#{Category.all[2].name}    ---    #{Category.all[2].clues.map {|clue| clue.point_value}.join(" | ")}".center(172)
    self.gap
    puts "#{Category.all[3].name}    ---    #{Category.all[3].clues.map {|clue| clue.point_value}.join(" | ")}".center(172)
    self.gap
    puts "#{Category.all[4].name}    ---    #{Category.all[4].clues.map {|clue| clue.point_value}.join(" | ")}".center(172)
    self.gap
    puts "#{Category.all[5].name}    ---    #{Category.all[5].clues.map {|clue| clue.point_value}.join(" | ")}".center(172)
  end



  def gap
    puts ""
    puts ""
    puts ""
  end
  
end



# change all `sleep(0)` to `sleep(1)`