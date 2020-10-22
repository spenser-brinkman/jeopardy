class Clue
  
  @@all = []

  attr_accessor :question, :answer, :points, :category

  def initialize(question, answer, points)
    @question = question
    @answer = answer
    @points = points
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