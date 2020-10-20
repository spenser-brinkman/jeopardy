class Fetcher

  BASE_URL = "http://jservice.io/"
  
  
  def self.fetch_six_categories
    parsed_url = URI.parse(BASE_URL + "api/random?count=6")
    response = Net::HTTP.get_response(parsed_url)
    categories = JSON.parse(response.body)
    categories.each do |category|
      name = category["category"]["title"].split(" ").map(&:capitalize).join(" ")
      date = category["airdate"].gsub(/T(.+)/, "")
      id = category["category_id"].to_s
      Category.new(name, date, id)
    end
  end
  
  def self.fetch_thirty_clues
    Category.all.each do |clue_category|
      category_name = clue_category
      category_id = clue_category.id
      parsed_url = URI.parse(BASE_URL + "api/category?id=" + category_id)
      response = Net::HTTP.get_response(parsed_url)
      clues = JSON.parse(response.body)["clues"]
      clues.take(5).each do |clue|
        category = category_name
        date = clue["airdate"].gsub(/T(.+)/, "")
        question = clue["question"]
        answer = clue["answer"]
        point_value = clue["value"]
        Clue.new(date, question, answer, point_value, category)
      end
    end
  end
end