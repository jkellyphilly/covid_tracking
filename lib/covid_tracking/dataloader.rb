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

    # create URI::HTTPS object using the url of the API
    url = URI("https://api.covid19api.com/summary")

    # create new Net::HTTP object
    https = Net::HTTP.new(url.host, url.port);

    # turn on SSL flag
    https.use_ssl = true

    # create Net::HTTP::Get object with the url
    request = Net::HTTP::Get.new(url)

    # use the Net::HTTP object to send a request for the information
    # and return the data via a string
    # TODO: check out JSON link
    #   see if I can parse with https://ruby-doc.org/stdlib-2.6.3/libdoc/json/rdoc/JSON.html
    #   or, check out HTTParty (Ruby gem)
    response = https.request(request).read_body

  end

  def make_summaries

    # First, clean up the given string
    summary_info = @data.split(/[{}]/)
    summary_info.reject! {|entry| entry == "" || entry == "\n" || entry == ","}

    # Take the first and last elements of the data array, which are
    # the global summary's name and timestamp
    global_name = summary_info.shift
    global_name.delete!("\":")
    global_date = summary_info.pop
    global_date.delete!("\"],")

    # Break apart the date and reformat it
    date_array = global_date.split(":")
    date_array.shift
    global_date = date_array.join(":")
    global_date.delete!("Z")
    global_date.gsub!("T", " ")
    global_date << " (UTC+0:00)"

    # Now, use the parser method to store the global's variables
    global_summary_info = summary_info.shift
    global_hash = parser(global_summary_info)

    # Update the global hash to include the name and date
    global_hash["name"] = global_name
    global_hash["date"] = global_date

    # Create the Summary object for global info
    CovidTracking::Summary.new(global_hash)

    country_section_heading = summary_info.shift
    country_section_heading.delete!(",\":[")

    if country_section_heading == "Countries"
      summary_info.each do |country_info|
        # Format the country_info string properly and create a hash with it
        country_info.delete!("\"")
        country_hash = parser(country_info)
        CovidTracking::CountrySummary.new(country_hash)
        # only load the country if one doesn't exist
      end
    else
      raise DataError
    end

  end

  # Returns a hash with key/value pairs to match
  # the formatting of a Summary object
  def parser(info_string)
    return_hash = {}

    # Format the info_string properly and break apart into
    # an array with all components
    info_string.delete!("\"")
    info = info_string.split(",")

    # Iterate through the given information and update the hash
    info.each do |entry|
      my_array = entry.split(":")
      title = my_array.shift
      if my_array.size == 1
        value = my_array[0]
      else
        value = my_array.join(":")
        value.delete!("Z")
        value.gsub!("T", " ")
        value << " (UTC+0:00)"
      end

      case title
      when "NewConfirmed"
        return_hash["new_confirmed"] = value.to_i
      when "TotalConfirmed"
        return_hash["total_confirmed"] = value.to_i
      when "NewDeaths"
        return_hash["new_deaths"] = value.to_i
      when "TotalDeaths"
        return_hash["total_deaths"] = value.to_i
      when "NewRecovered"
        return_hash["new_recovered"] = value.to_i
      when "TotalRecovered"
        return_hash["total_recovered"] = value.to_i
      when "Country"
        return_hash["name"] = value
      when "CountryCode"
        return_hash["country_code"] = value
      when "Date"
        return_hash["date"] = value
      end
    end

    return_hash
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
