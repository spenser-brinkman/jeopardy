class Fetcher

  attr_accessor :date, :category_list

  BASE_URL = "http://jservice.io/"

  def self.fetch_clues
    clues_array = []
    until clues_array.count == 30 && clues_array.all? {|c| c["answer"] != "" && c["question"] != "" && c["invalid_count"] == nil}
      @date = self.randomize_date
      parsed_url = URI.parse(BASE_URL + "api/clues?min_date=#{@date}&max_date=#{@date}")
      response = Net::HTTP.get_response(parsed_url)
      clues_array = JSON.parse(response.body)
      puts "."                                              # deleteme
    end
    category_one, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    category_two, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    category_three, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    category_four, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    category_five, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    category_six, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    @category_list = [category_one, category_two, category_three, category_four, category_five, category_six]
  end

  def self.organize_clues
    @category_list.each do |category|
      category_name = category[0]["category"]["title"].split(" ").map(&:capitalize).join(" ")
      new_category = Category.new(category_name, @date)
      category.each do |clue|
        question = clue["question"]
        answer = clue["answer"]
        point_value = clue["value"].to_s
        new_clue = Clue.new(question, answer, point_value)
        new_clue.category = new_category
      end
    end
  end






  
  # vv   The first episode of Jeopardy to use the current dollar amounts aired on Nov 26, 2001.   vv
  # vv          The most recent episode available from this API aired on Mar 31, 2015             vv
  
  def self.randomize_date  
    year = rand(2001..2015)
    if year == 2001
      month = rand(11..12)
      if month == 11
        day = rand(26..30)
      elsif month == 12
        day = rand(1..31)
      end
    elsif year == 2015
      month = rand(1..3)
      day = rand(1..31)
    else
      month = rand(1..12)
      day = rand(1..31)
    end
    random_date = "#{year.to_s}-#{month.to_s}-#{day.to_s}"
  end
end