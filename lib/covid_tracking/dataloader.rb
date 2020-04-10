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

  def call
    #"This is my call for now - this is simulating the data."
    url = URI("https://api.covid19api.com/summary")

    https = Net::HTTP.new(url.host, url.port);  
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request).read_body
    
    binding.pry
  end
  
  def make_summaries 
    puts "Making the summaries now..."
    # Make the summaries here 
    # array of info = @data.split(/[{}]/)
    # my_array.reject! {|entry| entry == "" || entry == "\n"}
    sleep (2)
    
    # Manually make the first one (Global data)
    # my_array.first.delete!("\":") # get rid of the special characters
    # global_sum = CovidTracking::Summary.new 
    # global_sum.name = my_array.shift # also removes the element from the array
    # global_sum_info = my_array.shift
    # parser(global_sum, global_sum_info)
    
    # Then, get time stamp for the global array (pop the last element and format it)
    
    # Now, we're left with an array (except for the "countries" first element)
    
    # my_array.each do |country|
      # store each country
      # country_hash = {}
      # 
    # end
    
  end
  
  def parser(summary, info_string)
    # Class to parse a string with all the info
    # use the argument input to store various data
    
    # new_array = info_string.split(",")
    # new_array.each do |entry|
      # title, value = entry.split(":")
      # case title 
      # when "TotalRecovered"
      # summary.total_recovered = value.to_i
      # perform for entire body (excluding time stamp)
    # end
  end 
end
