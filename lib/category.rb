class Category
  
  @@all = []

  attr_reader :name, :date, :id

  def initialize(name, date)
    @name = name
    @date = date
    @@all << self
  end

  def self.all
    @@all
  end

end