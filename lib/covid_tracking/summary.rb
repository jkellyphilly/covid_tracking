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
  
  def self.print_all
    self.all.each do |summary|
      puts "#{summary.name}:"
      puts "    New Confirmed Cases: #{summary.new_confirmed}"
      puts "    Total Confirmed Cases: #{summary.total_confirmed}"
      puts "    New Deaths: #{summary.new_deaths}"
      puts "    Total Deaths: #{summary.total_deaths}"
      puts "    New Recovered Cases: #{summary.new_recovered}"
      puts "    Total Recovered Cases: #{summary.total_recovered}"
      puts "This information was last updated at #{summary.date}"
    end
end