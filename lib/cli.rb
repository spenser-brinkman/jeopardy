class CLI

  def initialize
    @category_one = []
    @category_two = []
    @category_three = []
    @category_four = []
    @category_five = []
    @category_six = []
  end

  def run_2
    # self.intro
    Fetcher.fetch_clues
    Fetcher.organize_clues
    current_board
  end




  def current_board
    Art.logo_small
  end



























  def run
    # self.intro
    # self.gather_and_validate    #turn this on
    self.gather_categories        #turn these off
    self.gather_clues             #turn these off
    self.prompt_for_setup
    self.prompt_for_category
    self.prompt_for_value
    self.get_clue
    self.prompt_for_answer
    self.display_answer
  end

  def intro
    clear_screen
    sleep(1)
    puts "This!".center(172)
    31.times {puts ""}
    sleep(1.3)
    clear_screen
    puts "Is!".center(172)
    31.times {puts ""}
    sleep(1.3)
    clear_screen
    Art.title
    22.times {puts ""}
    sleep(2)
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
      break if self.valid?
    end
  end

  def valid?
    if Clue.all[0..30].all? {|c| c.instance_variable_get(:@point_value) != nil && c.instance_variable_get(:@invalid_count) == nil}
      true
    else
      false
    end
  end

  def prompt_for_setup
    loop do
      clear_screen
      puts "The following categories are from the year #{Category.all[0].year}.".center(172)
      gap
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
      gap
      puts "Would you like to play a game with these categories? (Y/N)".center(172)
      20.times {puts ""}
      setup_input = gets.chomp.capitalize
      sleep(0.3)
      if setup_input == "Y"
        clear_screen
        break      
      elsif setup_input == "N"
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

  # https://www.rubyguides.com/2012/01/ruby-string-formatting/ to clean this vvvv up

  def generate_board
    @row_one = [Category.all[0].clues[0], Category.all[0].clues[1], Category.all[0].clues[2], Category.all[0].clues[3], Category.all[0].clues[4]]
    @row_two = [Category.all[1].clues[0], Category.all[1].clues[1], Category.all[1].clues[2], Category.all[1].clues[3], Category.all[1].clues[4]]
    @row_three = [Category.all[2].clues[0], Category.all[2].clues[1], Category.all[2].clues[2], Category.all[2].clues[3], Category.all[2].clues[4]]
    @row_four = [Category.all[3].clues[0], Category.all[3].clues[1], Category.all[3].clues[2], Category.all[3].clues[3], Category.all[3].clues[4]]
    @row_five = [Category.all[4].clues[0], Category.all[4].clues[1], Category.all[4].clues[2], Category.all[4].clues[3], Category.all[4].clues[4]]
    @row_six = [Category.all[5].clues[0], Category.all[5].clues[1], Category.all[5].clues[2], Category.all[5].clues[3], Category.all[5].clues[4]]
    @all_rows = [@row_one, @row_two, @row_three, @row_four, @row_five, @row_six]
  end

  def display_starting_board
    self.gap
    puts "#{Category.all[0].name}   [1]".rjust(79) + "    ----    " + "#{@row_one[0].point_value} | #{@row_one[1].point_value} | #{@row_one[2].point_value} | #{@row_one[3].point_value} | #{@row_one[4].point_value}"
    self.gap
    puts "#{Category.all[1].name}   [2]".rjust(79) + "    ----    " + "#{@row_two[0].point_value} | #{@row_two[1].point_value} | #{@row_two[2].point_value} | #{@row_two[3].point_value} | #{@row_two[4].point_value}"
    self.gap
    puts "#{Category.all[2].name}   [3]".rjust(79) + "    ----    " + "#{@row_three[0].point_value} | #{@row_three[1].point_value} | #{@row_three[2].point_value} | #{@row_three[3].point_value} | #{@row_three[4].point_value}"
    self.gap
    puts "#{Category.all[3].name}   [4]".rjust(79) + "    ----    " + "#{@row_four[0].point_value} | #{@row_four[1].point_value} | #{@row_four[2].point_value} | #{@row_four[3].point_value} | #{@row_four[4].point_value}"
    self.gap
    puts "#{Category.all[4].name}   [5]".rjust(79) + "    ----    " + "#{@row_five[0].point_value} | #{@row_five[1].point_value} | #{@row_five[2].point_value} | #{@row_five[3].point_value} | #{@row_five[4].point_value}"
    self.gap
    puts "#{Category.all[5].name}   [6]".rjust(79) + "    ----    " + "#{@row_six[0].point_value} | #{@row_six[1].point_value} | #{@row_six[2].point_value} | #{@row_six[3].point_value} | #{@row_six[4].point_value}"
    self.gap
  end
  
  def prompt_for_category
    generate_board
    puts "Today's categories are:".center(172)
    loop do
      display_starting_board
      puts "Please enter 1-6 to select a category.".center(172)
      15.times {puts ""}
      @category_input = gets.chomp.to_i
      clear_screen
      if @category_input.between?(1, 6) # and category still has clues to answer
        @category_input -= 1
        puts "#{Category.all[@category_input].name} (#{Category.all[@category_input].year})".center(172)
        gap
        puts "#{@all_rows[@category_input][0].point_value}   [1]".center(172)
        puts ""
        puts "#{@all_rows[@category_input][1].point_value}   [2]".center(172)
        puts ""
        puts "#{@all_rows[@category_input][2].point_value}   [3]".center(172)
        puts ""
        puts "#{@all_rows[@category_input][3].point_value}   [4]".center(172)
        puts ""
        puts "#{@all_rows[@category_input][4].point_value}   [5]".center(172)
        gap
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
      22.times {puts ""}
      @value_input = gets.chomp.to_i
      @value_input -= 1
      if @value_input.between?(0, 4) # && user_input still exists as an index?
        break
      else
        puts "Sorry, you need to enter a number corresponding to one of the clues listed here:".center(172)
      end
    end
  end

  def get_clue
    clear_screen
    puts "(#{@all_rows[@category_input][@value_input].year})".center(172)
    puts ""
    puts "For #{@all_rows[@category_input][@value_input].point_value} points,".center(172)
    puts ""
    puts "from the category".center(172)
    puts ""
    puts "\"#{Category.all[@category_input].name}\":".center(172)
    gap
    puts "#{@all_rows[@category_input][@value_input].question}".center(172)
    26.times {puts ""}
  end

  def prompt_for_answer
    @answer_input = gets
  end

  def display_answer
    clear_screen
    puts "(#{@all_rows[@category_input][@value_input].year})".center(172)
    puts ""
    puts "For #{@all_rows[@category_input][@value_input].point_value} points,".center(172)
    puts ""
    puts "from the category".center(172)
    puts ""
    puts "\"#{Category.all[@category_input].name}\":".center(172)
    gap
    puts "#{@all_rows[@category_input][@value_input].question}".center(172)
    gap
    sleep(1)
    puts "You answered:".center(172)
    puts ""
    puts "#{@answer_input}".center(172)
    sleep(1)
    puts ""
    puts "The correct answer is:".center(172)
    puts ""
    puts "#{@all_rows[@category_input][@value_input].answer}".center(172)
    16.times {puts ""}
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
