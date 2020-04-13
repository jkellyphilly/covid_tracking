# Definition of the CountrySummary class

class CovidTracking::CountrySummary < CovidTracking::Summary 
  
  attr_accessor :country_code
  
  @@all_countries = []
  
  def self.all 
    @@all_countries
  end 
  
  def self.find_by_name(name)
    self.all.select {|country| country.name == name}
  end 
  
  def self.find_by_code(code)
    self.all.select {|country| country.country_code == code}
  end 
  
  # Print the full list of countries to choose from 
  def self.print_all_list
    self.all.each do |summary|
      puts "#{summary.name} (#{summary.country_code})"
    end
  end 
  
  # Print the attributes of this specific country 
  def print_info
    puts self.name
  end 
  
  
end