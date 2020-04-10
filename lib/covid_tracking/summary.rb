# Parent class for all summaries

class CovidTracking::Summary
  
  attr_accessor :name, :new_confirmed, :total_confirmed, :new_deaths, :total_deaths, :new_recovered, :total_recovered, :date 
  
  @@all = []
  
  def initialize(attributes)
    attributes.each {|key, value| self.send("#{key}=", value)}
    self.class.all << self
  end
  
  def self.all 
    @@all 
  end 
  
  def self.reset 
    self.all.clear
  end
  
end