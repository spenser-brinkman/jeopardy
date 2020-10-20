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

  def self.clues
    Clue.all.select {|clue| clue.category == self}
  end
end