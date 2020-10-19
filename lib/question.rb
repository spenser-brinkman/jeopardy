class Question
  attr_reader = :date, :question, :answer, :value, :category

  def initialize(date, question, answer, point_value, category)
    @date = date
    @question = question
    @answer = answer
    @point_value = point_value
    @category = category
  end
  
end