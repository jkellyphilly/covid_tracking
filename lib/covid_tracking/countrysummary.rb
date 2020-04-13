# Definition of the CountrySummary class

class CovidTracking::CountrySummary < CovidTracking::Summary 
  
  attr_accessor :country_code
  
  @@all_countries = []
  
  def self.all 
    @@all_countries
  end 
  
  def self.find_by_name(name)
    self.all.select {|country| country.name.downcase == name.downcase}
  end 
  
  def self.find_by_code(code)
    self.all.select {|country| country.country_code.downcase == code.downcase}
  end 
  
  # Print the full list of countries to choose from 
  def self.print_all_list
    self.all.each do |summary|
      puts "#{summary.name} (#{summary.country_code})"
    end
  end 
  
  # TODO: print the attributes in nicer colors
  # Print the attributes of this specific country 
  def print_info
    puts "#{self.name} (#{self.country_code}):"
    puts "    New Confirmed Cases: #{self.new_confirmed}"
    puts "    Total Confirmed Cases: #{self.total_confirmed}"
    puts "    New Deaths: #{self.new_deaths}"
    puts "    Total Deaths: #{self.total_deaths}"
    puts "    New Recovered Cases: #{self.new_recovered}"
    puts "    Total Recovered Cases: #{self.total_recovered}"
    puts "This information was last updated at #{self.date}"
  end
  
  # prints out the countries with the most cases 
  def self.most_cases
    most_cases_array = []
    
    sorted_array = CovidTracking::CountrySummary.all.sort_by {|country| country.total_confirmed}
    most_cases_array = sorted_array.select {|c| c.total_confirmed == sorted_array.last.total_confirmed}
  
    most_cases_array.each do |country|
      puts "     #{country.name}: #{country.total_confirmed} cases" 
    end
  end
  
  # prints out the countries with the least cases 
  def self.least_cases
    least_cases_array =[]
    
    sorted_array = CovidTracking::CountrySummary.all.sort_by {|country| country.total_confirmed}
    least_cases_array = sorted_array.select {|c| c.total_confirmed == sorted_array.first.total_confirmed}
  
    least_cases_array.each do |country|
      puts "     #{country.name}: #{country.total_confirmed} cases" 
    end
  end 
  
  # prints out the countries with the most new cases 
  def self.most_new_cases
    most_new_cases_array = []
    
    # loop through each element in ALL 
    # or, find out if there's a max function for the @@all_countries array 
  
    # most_new_cases_array.each do |country|
    # print out the country name and how many new cases it has 
    # end
  end
  
  def self.most_recovered_cases 
    most_rec_cases = []
    
    # loop through each element in ALL 
    # or, find out if there's max function 
    
    # most_rec_cases.each do |country|
    # print out country name and how many recovered cases it has 
    # end
  end 
end