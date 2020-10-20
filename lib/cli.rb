class CLI

  def run
    sleep(0)
    10.times {self.gap}
    puts "This!".center(172)
    puts ""
    sleep(0)
    puts "Is!".center(172)
    puts ""
    sleep(0)
    puts "Solo Jeopardy!".center(172)
    puts ""
    sleep(0)
    self.gap
    self.gather_and_validate    
    self.prompt_for_setup
    self.gap
    self.clear_screen
    self.display_starting_board
    self.prompt_for_category
  end

  def gather_categories
    Category.all.clear
    Fetcher.fetch_six_categories
    self.gap
    sleep(0)
  end

  def gather_clues
    Clue.all.clear
    Fetcher.fetch_thirty_clues
  end

  def gather_and_validate
    puts "Loading categories and validating clues.".center(172)
    loop do
      self.gather_categories
      self.gather_clues
      break if Clue.all[0..30].all? {|c| c.instance_variable_get(:@point_value) != nil}
    end
  end

  def prompt_for_setup
    loop do
      puts "The following categories are from the year #{Category.all[0].year}.".center(172)
      puts ""
      puts ""
      puts ""
      sleep(0)
      puts "#{Category.all[0].name}".center(172)
      puts ""
      puts "#{Category.all[1].name}".center(172)
      puts ""
      puts "#{Category.all[2].name}".center(172)
      puts ""
      puts "#{Category.all[3].name}".center(172)
      puts ""
      puts "#{Category.all[4].name}".center(172)
      puts ""
      puts "#{Category.all[5].name}".center(172)
      puts ""
      puts ""
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
        self.gather_and_validate
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

# https://www.rubyguides.com/2012/01/ruby-string-formatting/ to clean this vvvv upd

  def generate_board
    @row_one = ["#{Category.all[0].clues[0].point_value}", "#{Category.all[0].clues[1].point_value}", "#{Category.all[0].clues[2].point_value}", "#{Category.all[0].clues[3].point_value}", "#{Category.all[0].clues[4].point_value}"]
    @row_two = ["#{Category.all[1].clues[0].point_value}", "#{Category.all[1].clues[1].point_value}", "#{Category.all[1].clues[2].point_value}", "#{Category.all[1].clues[3].point_value}", "#{Category.all[1].clues[4].point_value}"]
    @row_three = ["#{Category.all[2].clues[0].point_value}", "#{Category.all[2].clues[1].point_value}", "#{Category.all[2].clues[2].point_value}", "#{Category.all[2].clues[3].point_value}", "#{Category.all[2].clues[4].point_value}"]
    @row_four = ["#{Category.all[3].clues[0].point_value}", "#{Category.all[3].clues[1].point_value}", "#{Category.all[3].clues[2].point_value}", "#{Category.all[3].clues[3].point_value}", "#{Category.all[3].clues[4].point_value}"]
    @row_five = ["#{Category.all[4].clues[0].point_value}", "#{Category.all[4].clues[1].point_value}", "#{Category.all[4].clues[2].point_value}", "#{Category.all[4].clues[3].point_value}", "#{Category.all[4].clues[4].point_value}"]
    @row_six = ["#{Category.all[5].clues[0].point_value}", "#{Category.all[5].clues[1].point_value}", "#{Category.all[5].clues[2].point_value}", "#{Category.all[5].clues[3].point_value}", "#{Category.all[5].clues[4].point_value}"]
  end

  def display_starting_board
    self.generate_board
    puts "Great! Today's categories are:".center(172)
    self.gap
    puts "#{Category.all[1].name} [1]".rjust(81) + "    ----    " + "#{@row_one[0]} | #{@row_one[1]} | #{@row_one[2]} | #{@row_one[3]} | #{@row_one[4]}".ljust(81)
    puts "#{Category.all[2].name} [2]".rjust(81) + "    ----    " + "#{@row_two[0]} | #{@row_two[1]} | #{@row_two[2]} | #{@row_two[3]} | #{@row_two[4]}".ljust(81)
    puts "#{Category.all[3].name} [3]".rjust(81) + "    ----    " + "#{@row_three[0]} | #{@row_three[1]} | #{@row_three[2]} | #{@row_three[3]} | #{@row_three[4]}".ljust(81)
    puts "#{Category.all[4].name} [4]".rjust(81) + "    ----    " + "#{@row_four[0]} | #{@row_four[1]} | #{@row_four[2]} | #{@row_four[3]} | #{@row_four[4]}".ljust(81)
    puts "#{Category.all[5].name} [5]".rjust(81) + "    ----    " + "#{@row_five[0]} | #{@row_five[1]} | #{@row_five[2]} | #{@row_five[3]} | #{@row_five[4]}".ljust(81)
    puts "#{Category.all[0].name} [6]".rjust(81) + "    ----    " + "#{@row_six[0]} | #{@row_six[1]} | #{@row_six[2]} | #{@row_six[3]} | #{@row_six[4]}".ljust(81)
  end

  def prompt_for_category
  end

  def gap
    puts ""
    puts ""
    puts ""
  end
  
  def clear_screen
    60.times do
      puts ""
    end
  end
end



# change all `sleep(0)` to `sleep(1)`