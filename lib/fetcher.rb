class Fetcher

  BASE_URL = "http://jservice.io/"
  
  
  def self.fetch_six_categories
    parsed_url = URI.parse(BASE_URL + "api/random?count=6")
    response = Net::HTTP.get_response(parsed_url)
    categories_hash = JSON.parse(response.body)
    categories_hash.each do |category|
      name = category["category"]["title"].split(" ").map(&:capitalize).join(" ")
      date = category["airdate"].gsub(/T(.+)/, "")
      id = category["category_id"].to_s
      Category.new(name, date, id)
    end
  end
  
  def self.parse_for_questions
    Category.all.each do |question_category|
      category_id = question_category.id
      parsed_url = URI.parse(BASE_URL + "api/category?id=" + category_id)
      response = Net::HTTP.get_response(parsed_url)
      questions_hash = JSON.parse(response.body)
      questions_hash
    end
  end
  
  def batch_question_creation
    
  end

end