# This file defines how I'm going to use the Coronavirus COVID19 API.
# The API is not my own, and the code for getting the data initialized and
# making the API call was also provided on Postman.

# For more details on implementation, please visit the link below.
# COVID19 API: https://documenter.getpostman.com/view/10808728/SzS8rjbc?version=latest#00030720-fae3-4c72-8aea-ad01ba17adf8

class CovidTracking::DataLoader

  attr_accessor :data

  def initialize
    @data = self.call
  end

  # Retrieve the data via COVID19 API
  def call
    url = URI("https://api.covid19api.com/summary")
    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    response = https.request(request).read_body

    data_hash = JSON.parse(response)
  end

  # Make all Summary and CountrySummary objects
  def make_summaries
    if @data.key?("Global") && @data.key?("Countries") && @data.key?("Date")
      global_data = @data["Global"]
      global_data["Date"] = @data["Date"]
      global_data["Country"] = "Global"

      # Clean up global_data with the parser method
      global_hash = parser(global_data)

      # Create the Summary object for global info
      CovidTracking::Summary.new(global_hash)

      @data["Countries"].each {|ctry_info| CovidTracking::CountrySummary.new(parser(ctry_info))}
    else
      raise DataError
    end

  end

  # Returns a hash with key/value pairs to match
  # the formatting of a Summary object
  def parser(info_hash)
    return_hash = {}
    info_hash.delete("Slug")

    # Iterate through the given information and update the hash
    info_hash.each do |key, value|
      attribute = camel_to_snake(key)

      if attribute == "date"
        return_hash[attribute] = date_formatter(value)
      else
        return_hash[attribute] = value
      end
    end

    return_hash
  end

  # Helper method for converting the date into user-friendly reading
  def date_formatter(date)
    date_array = date.split(":")

    # Clean up formatting
    date_array.first.gsub!("T", " ")
    date_array.last.delete!("Z")
    return_date = date_array.join(":")

    return_date << " (UTC+0:00)"
  end

  # Convert CamelCase to snake_case
  def camel_to_snake(input)
    input.gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase
  end

  def reset
    @data = self.call
    make_summaries
  end

  class DataError < StandardError
    def message
      "API data return format has changed: code will need to be updated."
    end
  end
end
