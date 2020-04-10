# Definition of the CountrySummary class

class CovidTracking::CountrySummary < CovidTracking::Summary 
  
  attr_accessor :country_code
  
  @@all = []
  
  #def initialize(attributes)
    # use metaprogramming to assign each attribute to its instance variable 
    # attributes.each {|key, value| self.send("#{key}=", value)
    # save
  #end 
  
  def save 
    self.class.all << self
  end 
  
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