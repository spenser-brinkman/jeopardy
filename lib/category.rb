class Category
  
  @@all = []

  attr_reader :name, :year, :id

  def initialize(name, year, id)
    @name = name
    @year = year
    @id = id
    @@all << self
  end

  def self.all
    @@all
  end

  def clues
    Clue.all.select {|c| c.category == self}
  end
end