class Clue
  
  @@all = []

  attr_accessor :question, :answer, :point_value, :category

  def initialize(question, answer, point_value)
    @question = question
    @answer = answer
    @point_value = point_value
    @@all << self
  end

  def self.all
    @@all
  end

  def category_name
    category.name if @category
  end
  
end