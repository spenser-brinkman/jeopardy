class CLI

  def run
    sleep(0)
    10.times {self.gap}
    puts "Welcome to Solo Jeopardy!".center(172)
    puts ""
    sleep(0)
    puts "Loading your categories, please wait.".center(172) 
    self.gap
    self.gather_categories
    self.prompt_for_input
    puts "Great! Please wait for your clues to load.".center(172)
    self.gap
    Fetcher.fetch_thirty_clues
    self.display_board
    binding.pry
  end

  def gather_categories
    Category.all.clear
    Fetcher.fetch_six_categories
    puts "Done!".center(172)
    self.gap
    sleep(0)
  end

  def prompt_for_input
    loop do
      puts "Here are the categories I came up with:".center(172)
      puts ""
      sleep(0)
      puts "#{Category.all[0].name.center(28)}|#{Category.all[1].name.center(28)}|#{Category.all[2].name.center(28)}|#{Category.all[3].name.center(28)}|#{Category.all[4].name.center(28)}|#{Category.all[5].name.center(28)}".center(172)
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
        sleep(2)
      end
    end
  end



  def generate_board
    @row_one = ["#{Category.all[0].clues[0].point_value}", "#{Category.all[0].clues[1].point_value}", "#{Category.all[0].clues[2].point_value}", "#{Category.all[0].clues[3].point_value}", "#{Category.all[0].clues[4].point_value}", "#{Category.all[0].clues[5].point_value}", ]
    @row_two = ["#{Category.all[1].clues[0].point_value}", "#{Category.all[1].clues[1].point_value}", "#{Category.all[1].clues[2].point_value}", "#{Category.all[1].clues[3].point_value}", "#{Category.all[1].clues[4].point_value}", "#{Category.all[1].clues[5].point_value}", ]
    @row_three = ["#{Category.all[2].clues[0].point_value}", "#{Category.all[2].clues[1].point_value}", "#{Category.all[2].clues[2].point_value}", "#{Category.all[2].clues[3].point_value}", "#{Category.all[2].clues[4].point_value}", "#{Category.all[2].clues[5].point_value}", ]
    @row_four = ["#{Category.all[3].clues[0].point_value}", "#{Category.all[3].clues[1].point_value}", "#{Category.all[3].clues[2].point_value}", "#{Category.all[3].clues[3].point_value}", "#{Category.all[3].clues[4].point_value}", "#{Category.all[3].clues[5].point_value}", ]
    @row_five = ["#{Category.all[4].clues[0].point_value}", "#{Category.all[4].clues[1].point_value}", "#{Category.all[4].clues[2].point_value}", "#{Category.all[4].clues[3].point_value}", "#{Category.all[4].clues[4].point_value}", "#{Category.all[4].clues[5].point_value}", ]
    @row_six = ["#{Category.all[5].clues[0].point_value}", "#{Category.all[5].clues[1].point_value}", "#{Category.all[5].clues[2].point_value}", "#{Category.all[5].clues[3].point_value}", "#{Category.all[5].clues[4].point_value}", "#{Category.all[5].clues[5].point_value}", ]
  end

  def display_board
    self.generate_board
    puts "#{Category.all[1].name}    ---    #{@row_one[0]} | #{@row_one[1]} | #{@row_one[2]} | #{@row_one[3]} | #{@row_one[4]} | #{@row_one[5]}".center(172)
    puts "#{Category.all[2].name}    ---    #{@row_two[0]} | #{@row_two[1]} | #{@row_two[2]} | #{@row_two[3]} | #{@row_two[4]} | #{@row_two[5]}".center(172)
    puts "#{Category.all[3].name}    ---    #{@row_three[0]} | #{@row_three[1]} | #{@row_three[2]} | #{@row_three[3]} | #{@row_three[4]} | #{@row_three[5]}".center(172)
    puts "#{Category.all[4].name}    ---    #{@row_four[0]} | #{@row_four[1]} | #{@row_four[2]} | #{@row_four[3]} | #{@row_four[4]} | #{@row_four[5]}".center(172)
    puts "#{Category.all[5].name}    ---    #{@row_five[0]} | #{@row_five[1]} | #{@row_five[2]} | #{@row_five[3]} | #{@row_five[4]} | #{@row_five[5]}".center(172)
    puts "#{Category.all[0].name}    ---    #{@row_six[0]} | #{@row_six[1]} | #{@row_six[2]} | #{@row_six[3]} | #{@row_six[4]} | #{@row_six[5]}".center(172)
  end



  def gap
    puts ""
    puts ""
    puts ""
  end
  
end



# change all `sleep(0)` to `sleep(1)`