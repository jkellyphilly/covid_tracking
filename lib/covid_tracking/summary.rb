# Parent class for all summaries

class CovidTracking::Summary

  attr_accessor :country, :new_confirmed, :total_confirmed, :new_deaths, :total_deaths, :new_recovered, :total_recovered, :date, :premium

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
      puts "#{summary.country}:".light_cyan
      puts "    New Confirmed Cases: #{summary.new_confirmed}".light_red
      puts "    Total Confirmed Cases: #{summary.total_confirmed}".light_red
      puts "    New Deaths: #{summary.new_deaths}".light_red
      puts "    Total Deaths: #{summary.total_deaths}".light_red
      puts "    New Recovered Cases: #{summary.new_recovered}".light_red
      puts "    Total Recovered Cases: #{summary.total_recovered}".light_red
      puts "This information was last updated at #{summary.date}".light_cyan
    end
  end
end
