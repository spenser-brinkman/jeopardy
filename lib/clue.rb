class Clue
  
  @@all = []

  attr_accessor :year, :question, :answer, :point_value, :category, :invalid_count

  def initialize(year, question, answer, point_value, category, invalid_count)
    @year = year
    @question = question
    @answer = answer
    @point_value = point_value
    @category = category
    @invalid_count = invalid_count
    @@all << self
  end

  def self.all
    @@all
  end

end