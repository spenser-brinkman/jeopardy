class Clue
  
  @@all = []

  attr_accessor :year, :question, :answer, :point_value, :category

  def initialize(year, question, answer, point_value, category)
    @year = year
    @question = question
    @answer = answer
    @point_value = point_value
    @category = category
    @@all << self
  end

  def self.all
    @@all
  end

end