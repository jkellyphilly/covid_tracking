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
    self.all.select {|country| country.name == name}
  end 
  
  def self.find_by_code(code)
    self.all.select {|country| country.country_code == code}
  end 
  
  def self.print_all_list
    self.all.each do |summary|
      puts "#{summary.name} (#{summary.country_code})"
    end
  end 
  
end