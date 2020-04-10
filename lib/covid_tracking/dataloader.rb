# This file defines how I'm going to use the Coronavirus COVID19 API.
# The API is not my own, and the code for getting the data initialized and
# making the API call was also provided on Postman.

# For more details on implementation, please visit the link below.
# COVID19 API: https://documenter.getpostman.com/view/10808728/SzS8rjbc?version=latest#00030720-fae3-4c72-8aea-ad01ba17adf8

class CovidTracking::DataLoader

  attr_accessor :data

  def initialize
    @data = self.call
    self.make_summaries
  end
  
  # TODO: Explain this method more fully
  # Retrieve the data via COVID API
  def call
    url = URI("https://api.covid19api.com/summary")
    
    https = Net::HTTP.new(url.host, url.port);  
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request).read_body
  end
  
  def make_summaries 
    puts "Data loaded. Making the summaries now..."
    sleep(2)
    
    # First, clean up the given string  
    summary_info = @data.split(/[{}]/)
    summary_info.reject! {|entry| entry == "" || entry == "\n"}
    
    
    # Take the first and last elements of the data array, which are 
    # the global summary's name and timestamp
    global_name = summary_info.shift
    global_name.delete!("\":")
    global_date = summary_info.pop
    global_date.delete!("\"],")
    # TODO: break apart the date
    
    # Now, use the parser method to store the global's variables
    global_summary_info = summary_info.shift
    global_hash = parser(global_summary_info)
    
    # Update the global hash to include the name and date
    global_hash["name"] = global_name
    global_hash["date"] = global_date
    
    # Create the Summary object for global info 
    global = CovidTracking::Summary.new(global_hash)
    
    binding.pry
    
    # Now, we're left with an array (except for the "countries" first element)
    
    # my_array.each do |country|
      # store each country
      # country_hash = {}
      # 
    # end
    
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
      title, value = entry.split(":")
      # TODO: Build a method that converts the CamelCase title 
      # into a string_like_this that I can use to make it easier 
      # to make a key
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
      end
    end
    
    return_hash
  end 
end
