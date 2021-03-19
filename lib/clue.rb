class Clue
  
  @@all = []

  attr_accessor :question, :answer, :points, :category, :helper_daily_double, :scoring_daily_double, :getter_input, :answered

  def initialize(question, answer, points, helper_daily_double, scoring_daily_double)
    @question = question
    @answer = answer
    @points = points
    @helper_daily_double = helper_daily_double
    @scoring_daily_double = scoring_daily_double
    @answered = false
    @@all << self
  end

  def self.all
    self
    @@all
  end
  
  def self.clear_all
    @@all.clear
  end

  def category_name
    category.name if @category
  end

  def self.generate_getter
    letters = {0 => "A", 1 => "B", 2 => "C", 3 => "D", 4 => "E", 5 => "F"}
    numbers = {200 => "1", 400 => "2", 600 => "3", 800 => "4", 1000 => "5"}
    getter_input = "#{letters[@i]}#{numbers[@p]}"
    getter_input
  end

  def self.assign_getters
    @i = 0
    @p = 0
    until Clue.all.all? {|clue| clue.instance_variable_defined?("@getter_input")}
      Category.all[@i].clues.each do |c|        
        if c.helper_daily_double == nil
          @p = c.points
          c.getter_input = self.generate_getter
        elsif c.helper_daily_double == true
          @p += 200
          c.points = @p
          c.helper_daily_double = false
          c.getter_input = self.generate_getter
        end
      end
      @i += 1
    end
  end
end