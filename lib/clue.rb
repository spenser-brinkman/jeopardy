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
    @@all
  end
  
  def self.clear_all
    @@all.clear
  end

  def category_name
    category.name if @category
  end

  def self.generate_getter
    if @i == 0
      letter = "A"
    elsif @i == 1
      letter = "B"
    elsif @i == 2
      letter = "C"
    elsif @i == 3
      letter = "D"
    elsif @i == 4
      letter = "E"
    elsif @i == 5
      letter = "F"
    end
    if @p == 200
      number = "1"
    elsif @p == 400
      number = "2"
    elsif @p == 600
      number = "3"
    elsif @p == 800
      number = "4"
    elsif @p == 1000
      number = "5"
    end
    getter_input = "#{letter}#{number}"
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