# Definition of the CountrySummary class

class CovidTracking::CountrySummary < CovidTracking::Summary 
  
  attr_accessor :country_code
  
  @@all_countries = []
  
  def initialize(attributes)
    # use metaprogramming to assign each attribute to its instance variable 
    super
    save
  end 
  
  def save 
    self.class.all << self
  end 
  
  def self.all 
    @@all_countries
  end 
  
  def self.reset 
    self.all.clear
  end 
  
  def self.find_by_name(name)
    # Iterate through all countries
  end 
  
end