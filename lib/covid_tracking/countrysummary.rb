# Definition of the CountrySummary class

class CountrySummary < Summary 
  
  attr_accessor :country_code
  
  @@all = []
  
  def self.all 
    @@all
  end 
  
  def self.reset 
    self.all.clear
  end 
  
  def self.find_by_name(name)
    # Iterate through all countries
  end 
  
end