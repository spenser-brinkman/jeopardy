class Clue
  
  @@all = []

  attr_accessor :question, :answer, :points, :category, :helper_daily_double, :scoring_daily_double

  def initialize(question, answer, points, helper_daily_double, scoring_daily_double)
    @question = question
    @answer = answer
    @points = points
    @helper_daily_double = helper_daily_double
    @scoring_daily_double = scoring_daily_double
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

end