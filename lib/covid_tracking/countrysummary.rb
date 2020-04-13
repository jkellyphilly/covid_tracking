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
  
end