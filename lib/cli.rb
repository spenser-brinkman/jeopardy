class CLI

  def run
    clear_screen
    sleep(1)                               #1
    puts "This!".center(172)
    31.times {puts ""}
    sleep(1.3)                               #2
    clear_screen
    puts "Is!".center(172)
    31.times {puts ""}
    sleep(1.3)                               #2
    clear_screen
    Art.title
    22.times {puts ""}
    sleep(2)                               #3
    self.gather_and_validate    #turn this on
    # self.gather_categories        #turn these off
    # self.gather_clues             #turn these off
    self.prompt_for_setup
    clear_screen
    self.prompt_for_category
    self.prompt_for_value
  end

  def gather_categories
    Category.all.clear
    Fetcher.fetch_six_categories
  end

  def gather_clues
    Clue.all.clear
    Fetcher.fetch_thirty_clues
  end

  def gather_and_validate
    @i = 1
    loop do
      clear_screen
      puts "Loading categories and validating clues.".center(172)
      puts ""
      if @i % 3 == 1
        puts ".".rjust(85)
      elsif @i % 3 == 2
        puts "..".rjust(86)
      elsif @i % 3 == 0
        puts "...".rjust(87)
      end
      29.times {puts ""}
      @i += 1
      self.gather_categories
      self.gather_clues
      break if Clue.all[0..30].all? {|c| c.instance_variable_get(:@point_value) != nil}
    end
  end

  # def gather_and_validate
  #   @i = 0
  #   validator = Clue.all[0..30].all? {|c| c.instance_variable_get(:@point_value) != nil}
  #   until validator
  #     self.gather_categories
  #     self.gather_clues
  #     @i += 1
  #     i.times {print "."}
  #   end
  # end




  def prompt_for_setup
    loop do
      clear_screen
      puts "The following categories are from the year #{Category.all[0].year}.".center(172)
      puts ""
      puts ""
      puts ""
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
      puts "Would you like to play a game with these categories? (Y/N)".center(172)
      20.times {puts ""}
      player_input = gets.chomp.capitalize
      sleep(0.3)
      if player_input == "Y"
        break      
      elsif player_input == "N"
        clear_screen
        puts "Okay, let's get a new set of categories.".center(172)
        31.times {puts ""}
        sleep(1)
        self.gather_and_validate
      else
        clear_screen
        puts "Sorry, you'll need to enter:".center(172)
        puts ""
        puts "Y for 'yes'".center(172)
        puts ""
        puts "or".center(172)
        puts ""
        puts "N for 'no'".center(172)
        27.times {puts ""}
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
    self.gap
    puts "#{Category.all[1].name}   [1]".rjust(79) + "    ----    " + "#{@row_one[0]} | #{@row_one[1]} | #{@row_one[2]} | #{@row_one[3]} | #{@row_one[4]}"
    self.gap
    puts "#{Category.all[2].name}   [2]".rjust(79) + "    ----    " + "#{@row_two[0]} | #{@row_two[1]} | #{@row_two[2]} | #{@row_two[3]} | #{@row_two[4]}"
    self.gap
    puts "#{Category.all[3].name}   [3]".rjust(79) + "    ----    " + "#{@row_three[0]} | #{@row_three[1]} | #{@row_three[2]} | #{@row_three[3]} | #{@row_three[4]}"
    self.gap
    puts "#{Category.all[4].name}   [4]".rjust(79) + "    ----    " + "#{@row_four[0]} | #{@row_four[1]} | #{@row_four[2]} | #{@row_four[3]} | #{@row_four[4]}"
    self.gap
    puts "#{Category.all[5].name}   [5]".rjust(79) + "    ----    " + "#{@row_five[0]} | #{@row_five[1]} | #{@row_five[2]} | #{@row_five[3]} | #{@row_five[4]}"
    self.gap
    puts "#{Category.all[0].name}   [6]".rjust(79) + "    ----    " + "#{@row_six[0]} | #{@row_six[1]} | #{@row_six[2]} | #{@row_six[3]} | #{@row_six[4]}"
    self.gap
  end
  
  def prompt_for_category
    generate_board
    puts "Today's categories are:".center(172)
    loop do
      player_input = ""
      display_starting_board
      puts "Please enter 1-6 to select a category.".center(172)
      15.times {puts ""}
      player_input = gets.chomp.to_i
      if player_input == 1
        clear_screen
        puts "#{Category.all[1].name}".rjust(79) + "    ----    " + "#{@row_one[0]} | #{@row_one[1]} | #{@row_one[2]} | #{@row_one[3]} | #{@row_one[4]}"
        puts ""
        puts "".rjust(79) + "            [1]   [2]   [3]   [4]   [5] "
        29.times {puts ""}
        break
      elsif player_input == 2
        clear_screen
        puts "#{Category.all[2].name}".rjust(79) + "    ----    " + "#{@row_two[0]} | #{@row_two[1]} | #{@row_two[2]} | #{@row_two[3]} | #{@row_two[4]}"
        puts ""
        puts "".rjust(79) + "            [1]   [2]   [3]   [4]   [5] "
        29.times {puts ""}
        break
      elsif player_input == 3
        clear_screen
        puts "#{Category.all[3].name}".rjust(79) + "    ----    " + "#{@row_three[0]} | #{@row_three[1]} | #{@row_three[2]} | #{@row_three[3]} | #{@row_three[4]}"
        puts ""
        puts "".rjust(79) + "            [1]   [2]   [3]   [4]   [5] "
        29.times {puts ""}
        break
      elsif player_input == 4
        clear_screen
        puts "#{Category.all[4].name}".rjust(79) + "    ----    " + "#{@row_four[0]} | #{@row_four[1]} | #{@row_four[2]} | #{@row_four[3]} | #{@row_four[4]}"
        puts ""
        puts "".rjust(79) + "            [1]   [2]   [3]   [4]   [5] "
        29.times {puts ""}
        break
      elsif player_input == 5
        clear_screen
        puts "#{Category.all[5].name}".rjust(79) + "    ----    " + "#{@row_five[0]} | #{@row_five[1]} | #{@row_five[2]} | #{@row_five[3]} | #{@row_five[4]}"
        puts ""
        puts "".rjust(79) + "            [1]   [2]   [3]   [4]   [5] "
        29.times {puts ""}
        break
      elsif player_input == 6
        clear_screen
        puts "#{Category.all[0].name}".rjust(79) + "    ----    " + "#{@row_six[0]} | #{@row_six[1]} | #{@row_six[2]} | #{@row_six[3]} | #{@row_six[4]}"
        puts ""
        puts "".rjust(79) + "            [1]   [2]   [3]   [4]   [5] "
        29.times {puts ""}
        break
      else
        clear_screen
        puts "Sorry, you need to enter a number corresponding to one of the categories listed here:".center(172)
      end
    end
  end

  def prompt_for_value
    loop do
      puts "Please enter a number corresponding to the point value of an available clue.".center(172)
      user_input = gets.chomp.to_i
      user_input -= 1
      if user_input.between?(0, 4) # && user_input.exists?
        puts "A"
      else
        puts "Sorry, you need to enter a number corresponding to one of the categories listed here:".center(172)
      end
    end
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
