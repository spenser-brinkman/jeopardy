class Category
  
  attr_accessor :name, :year, :id

  def initialize(name, year, id)
    @name = name
    @year = year
    @id = id
    @@all << self
  end

  def 

  def clues
    Clue.all.select {|c| c.category == self}
  end
end