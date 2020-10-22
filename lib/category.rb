class Category
  
  @@all = []

  attr_accessor :name, :date

  def initialize(name, date)
    @name = name
    @date = date
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear_all
    @@all.clear
  end
  
  def self.new_category(name, date)
    @name = name
    @date = date
    @@all << self
  end

  def add_category_to_clue(clue)
    clue.category = self
  end

  def new_clue_by_category(question, answer, points)
    clue = Clue.new(question, answer, points)
    add_category_to_clue(clue)
  end

  def clues
    Clue.all.select {|c| c.category == self}
  end
end