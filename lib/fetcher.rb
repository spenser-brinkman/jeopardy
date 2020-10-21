class Fetcher

  BASE_URL = "http://jservice.io/"

  def self.fetch_clues
    categories = []
    until categories.count == 30 && categories.all? {|c| c["answer"] != "" && c["question"] != "" && c["invalid_count"] == nil}
      date = self.randomize_date
      parsed_url = URI.parse(BASE_URL + "api/clues?min_date=#{date}&max_date=#{date}")
      response = Net::HTTP.get_response(parsed_url)
      categories = JSON.parse(response.body)
      puts "."                                              # deleteme
    end
  end

  
  # vv The first episode of Jeopardy to use the current dollar amounts aired on Nov 26, 2001. vv
  # vv The most recent episode available from this API aired on Mar 31, 2015                  vv
  
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