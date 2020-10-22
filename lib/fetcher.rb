class Fetcher

  attr_accessor :date, :category_list

  BASE_URL = "http://jservice.io/"

  def self.fetch_clues
    Clue.clear_all
    Category.clear_all
    clues_array = []
    i = 1
    until clues_array.count == 30 && clues_array.all? {|c| c["answer"] != "" && c["question"] != "" && c["invalid_count"] == nil}
      puts "Loading categories and validating clues.".center(172)
      puts ""
      if i % 3 == 1
        puts ".".rjust(85)
      elsif i % 3 == 2
        puts "..".rjust(86)
      elsif i % 3 == 0
        puts "...".rjust(87)
      end
      29.times {puts ""}
      i += 1
      self.randomize_date
      parsed_url = URI.parse(BASE_URL + "api/clues?min_date=#{@date}&max_date=#{@date}")
      response = Net::HTTP.get_response(parsed_url)
      clues_array = JSON.parse(response.body)
    end
    category_one, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    category_two, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    category_three, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    category_four, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    category_five, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    category_six, clues_array = clues_array.partition {|clue| clue["category_id"] == clues_array[0]["category_id"]}
    @category_list = [category_one, category_two, category_three, category_four, category_five, category_six]
    self.organize_clues
  end

  def self.organize_clues
    @category_list.each do |category|
      category_name = category[0]["category"]["title"].split(" ").map(&:capitalize).join(" ")
      date = Date.parse(@date).strftime('%B %-d, %Y')
      new_category = Category.new(category_name, date)
      category.each do |clue|
        question = clue["question"]
        answer = clue["answer"]
        points = clue["value"].to_s
        new_clue = Clue.new(question, answer, points)
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
    @date = "#{year.to_s}-#{month.to_s}-#{day.to_s}"
  end
end