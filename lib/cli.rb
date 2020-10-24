class CLI
  # @@point_total = 0

  def run
    String.color_samples
    @@point_total = 0
    self.intro
    Fetcher.fetch_clues
    self.prompt_for_setup
    Clue.assign_getters
    until self.board_empty?
      self.play 
    end
    Art.board
    self.game_over

  end

  def intro
    60.times {puts ""}
    sleep(1)
    30.times {puts ""}
    puts "This!".center(172)
    29.times {puts ""}
    sleep(1.3)
    30.times {puts ""}
    puts "Is!".center(172)
    29.times {puts ""}
    sleep(1.3)
    20.times {puts ""}
    Art.title
    20.times {puts ""}
    sleep(3)
  end

  def prompt_for_setup
    loop do
      20.times {puts ""}
      puts "The following categories are from an episode which aired #{Category.all[0].date}.".center(172)
      3.times {puts ""}
      Category.all.each do |cat|
        puts "#{cat.name}".center(172)
        puts ""
      end
      2.times {puts ""}
      puts "Would you like to play a game with these categories? [Y/N]".center(172)
      20.times {puts ""}
      setup_input = gets.chomp.upcase
      if ["Y", "YES", "YEP", "YEAH", "YUP", "UH-HUH", "SURE", "YA", "YEA", "OK", "O.K."].include? setup_input
        clear_screen
        break      
      elsif ["N", "NOPE", "NO", "NAH", "NO WAY", "NO WAY, JOSE", "NO THANKS"].include? setup_input
        30.times {puts ""}
        puts "Okay, let's get a new set of categories.".center(172)
        29.times {puts ""}
        sleep(1.5)
        Fetcher.fetch_clues
      else
        clear_screen
        puts "Sorry, you'll need to enter:".center(172)
        puts ""
        puts "Y for \"yes\"".center(172)
        puts ""
        puts "or".center(172)
        puts ""
        puts "N for \"no\"".center(172)
        26.times {puts ""}
        sleep(2)
      end
    end
  end

  def play
    Art.board
    self.select_clue
    self.prompt_for_answer
    self.ask_if_correct
  end

  def board_empty?
    Clue.all.all? {|clue| clue.answered == true}
  end

  def self.category_empty?(category)
    category.clues.all? {|clue| clue.answered == true}
  end
  
  def self.disp_cat(category, x)
    if category_empty?(category)
      ""
    else
      multiline_cat_name = ["", ""]                                                     # this method splits long
      i = 0                                                                             # 
      multiline_cat_name.map do |line|                                                  # category names into smaller pieces
        line = category.name.scan(/.{1,20}\b/)[i]                                       #
        line != nil ? multiline_cat_name[i] = line : nil                                # to be displayed in the board's boxes
        i += 1
      end
      split_string_array = multiline_cat_name.map { |line| line.delete_suffix(" ") }
      split_string_array[x]
    end
  end

  def self.disp_points(getter_input)
    Clue.all.detect do |c|
      if c.getter_input == getter_input
        if c.answered == false
          @response = c.points
        elsif c.answered == true
          if c.points.between?(200, 800)
            @response = "   "
          elsif c.points == 1000
            @response = "    "
          end
        end
      end
    end
    @response
  end

  def select_clue
    puts "Please enter a letter-number combination corresponding to an available clue.".center(172)
    self.show_score
    loop do
      clue_choice = gets.chomp.capitalize
      @chosen_clue = ""
      Clue.all.detect {|clue| clue.getter_input == clue_choice } ? @chosen_clue = Clue.all.detect {|clue| clue.getter_input == clue_choice } : nil
      if @chosen_clue == ""
        Art.board
        puts "(Sorry, that was an invalid selection. Please enter a letter-number combination corresponding to an available clue.)".center(172)
        self.show_score
      elsif @chosen_clue.answered == true
        Art.board
        puts "(Sorry, that clue has already been selected. Please enter a letter-number combination corresponding to an available clue.)".center(172)
        self.show_score
      elsif @chosen_clue.answered == false
        @chosen_clue.answered = true
        if @chosen_clue.scoring_daily_double == true
          self.daily_double_prompt
        end
        self.display_clue
        break
      end 
    end
  end
    
  def show_score
    if @@point_total != 0
      puts "" 
      puts "You currently have #{@@point_total} points.".center(172)
    else 2.times {puts ""}
    end
    4.times {puts ""}
  end

  def daily_double_prompt
    20.times {puts ""}
    puts "You have selected the daily double!".center(172)
    2.times {puts ""}
    puts "You may risk up to as many points as you have for a chance to double them.".center(172)
    2.times {puts ""}
    puts "If you have fewer than 2000 points, you may risk up to 2000 points.".center(172)
    2.times {puts ""}
    puts "If you answer incorrectly, the risked points will be deducted from your score.".center(172)
    2.times {puts ""}
    puts "You may also choose to risk 0 points.".center(172)
    2.times {puts ""}
    puts "The clue's category is \"#{@chosen_clue.category.name}\", and its original point value was #{@chosen_clue.points}.".center(172)
    2.times {puts ""}
    if @@point_total < 2000
      puts "You currently have #{@@point_total} points, so you may risk up to 2000. How many would you like to risk?".center(172)
    elsif @@point_total >= 2000
      puts "You currently have #{@@point_total} points. How many would you like to risk?".center(172)
    end
    20.times {puts ""}
    @@point_total <= 2000 ? @max_wager = 2000 : @max_wager = @@point_total
    loop do
      begin
        @wager = gets.chomp
        @wager = Integer(@wager)
      rescue ArgumentError
        23.times {puts ""}
        puts "(Sorry, you'll need to enter a number of points to risk on the Daily Double.)".center(172)
        self.daily_double_error_template
        retry
      end
      if @wager <= @max_wager
        @chosen_clue.answered = true
        break
      elsif @wager > @max_wager
        23.times {puts ""}
        puts "(Sorry, you don't have enough points to risk that many. Please enter a different amount to risk on the Daily Double.)".center(172)
        self.daily_double_error_template
      end
    end
  end

  def daily_double_error_template
    2.times {puts ""}
    puts "You currently have #{@@point_total} points.".center(172)
    2.times {puts ""}
    puts "The clue's category is \"#{@chosen_clue.category.name}\", and its original point value was #{@chosen_clue.points}.".center(172)
    2.times {puts ""}
    puts "You are able to risk up to #{@max_wager} points.".center(172)
    2.times {puts ""}
    puts "You may also choose to risk 0 points.".center(172)
    24.times {puts ""}
  end

  def display_clue
    Art.board
    if @chosen_clue.scoring_daily_double == true
      puts "\"#{@chosen_clue.category.name}\" for #{@wager}:".center(172)
      puts ""
      puts "#{@chosen_clue.question}".center(172)
      puts ""
    else
      puts "\"#{@chosen_clue.category.name}\" for #{@chosen_clue.points}:".center(172)
      puts ""
      puts "#{@chosen_clue.question}".center(172)
      puts ""
    end
  end


  def fit_clue
    
  end


  def prompt_for_answer
    puts ""
    puts "Please enter your answer.".center(172)
    puts ""
    @player_answer = gets.chomp
    display_clue
    puts "You answered \"#{@player_answer}\".  The correct answer is \"#{@chosen_clue.answer}\".".center(172)
    puts ""
  end

  def ask_if_correct
    puts "This game is based on the honor system; would Trebek have accepted your answer? [Y/N]".center(172)
    loop do
      trust_fall = gets.chomp.upcase
      if ["N", "NOPE", "NO", "NAH", "NO WAY", "NO WAY, JOSE", "NO THANKS"].include? trust_fall
        Art.board
        2.times {puts ""}
        if @chosen_clue.scoring_daily_double == true
          puts "Unfortunately, because you incorrectly answered the Daily Double clue, #{@wager} points have been deducted from your score.".center(172) 
          @@point_total -= @wager
        else
          puts "Thanks for being honest!".center(172)
        end
        4.times {puts ""}
        sleep(2)
        break
      elsif ["Y", "YES", "YEP", "YEAH", "YUP", "UH-HUH", "SURE", "YA", "YEA", "OK", "O.K.", "DUH"].include? trust_fall
        self.add_points
        Art.board
        2.times {puts ""}
        puts "Good job!".center(172)
        4.times {puts ""}
        sleep(2)
        break
      else
        display_clue
        puts "You answered \"#{@player_answer}\".  The correct answer is \"#{@chosen_clue.answer}\".".center(172)
        puts ""
        puts "(Sorry, you'll need to answer whether you got the question right or not. [Y/N] No judgement!)".center(172)
      end
    end
  end

  def add_points
    @chosen_clue.scoring_daily_double == true ? @@point_total += @wager : @@point_total += @chosen_clue.points
    Art.board
    2.times {puts ""}
    puts "Your current point total is #{@@point_total}."
    4.times {puts ""}
  end

  def game_over
    self.game_over_msg_base
    puts "Would you like to start a new game? [Y/N]".center(172)
    27.times {puts ""}
    loop do
      new_game_input = gets.chomp.upcase
      if ["N", "NOPE", "NO", "NAH", "NO WAY", "NO WAY, JOSE", "NO THANKS"].include? new_game_input
        29.times {puts ""}
        puts "Thanks for playing! Until next time!".center(172)
        30.times {puts ""}
        sleep(2)
        break
      elsif ["Y", "YES", "YEP", "YEAH", "YUP", "UH-HUH", "SURE", "YA", "YEA", "OK", "O.K.", "DUH"].include? new_game_input
        self.run
        break
      else
        self.game_over_msg_base
        puts "(Sorry, you'll need to enter Y for \"yes\" or N for \"no\")".center(172)
        27.times {puts ""}
      end
    end
  end
  
  def game_over_msg_base
    26.times {puts ""}
    puts "There are no more clues to answer!".center(172)
    puts ""
    puts "Your final score is #{@@point_total}.".center(172)
    puts ""
    puts "Thanks for playing!".center(172)
    puts ""
  end

  def clear_screen
    60.times do
      puts ""
    end
  end
end