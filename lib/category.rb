class Category
  
  @@all = []

  attr_reader :name, :date, :id

  def initialize(name, date, id)
    @name = name
    @date = date
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