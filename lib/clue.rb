class Clue
  
  @@all = []

  attr_accessor :date, :question, :answer, :point_value, :category

  def initialize(date, question, answer, point_value, category)
    @date = date
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