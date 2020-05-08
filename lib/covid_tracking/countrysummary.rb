# Definition of the CountrySummary class

class CovidTracking::CountrySummary < CovidTracking::Summary

  attr_accessor :country_code

  @@all_countries = []

  def self.all
    @@all_countries
  end

  def self.find_by_name(name)
    self.all.select {|country| country.country.downcase == name.downcase}
  end

  def self.find_by_code(code)
    self.all.select {|country| country.country_code.downcase == code.downcase}
  end

  # Print the full list of countries to choose from
  def self.print_all_list
    self.all.each do |summary|
      puts "#{summary.country} (#{summary.country_code})".light_cyan
    end
  end

  # Print the attributes of this specific country
  def print_info
    puts "#{self.country} (#{self.country_code}):".light_cyan
    puts "    New Confirmed Cases: #{self.new_confirmed}".light_red
    puts "    Total Confirmed Cases: #{self.total_confirmed}".light_red
    puts "    New Deaths: #{self.new_deaths}".light_red
    puts "    Total Deaths: #{self.total_deaths}".light_red
    puts "    New Recovered Cases: #{self.new_recovered}".light_red
    puts "    Total Recovered Cases: #{self.total_recovered}".light_red
    puts "This information was last updated at #{self.date}".light_cyan
  end

  # prints out the countries with the most cases
  def self.most_cases
    most_cases_array = []

    sorted_array = CovidTracking::CountrySummary.all.sort_by {|country| country.total_confirmed}
    most_cases_array = sorted_array.select {|c| c.total_confirmed == sorted_array.last.total_confirmed}

    most_cases_array.each do |country|
      puts "     #{country.country}: #{country.total_confirmed} total cases".light_cyan
    end
  end

  # prints out the countries with the least cases
  def self.least_cases
    least_cases_array =[]

    sorted_array = CovidTracking::CountrySummary.all.sort_by {|country| country.total_confirmed}
    least_cases_array = sorted_array.select {|c| c.total_confirmed == sorted_array.first.total_confirmed}

    least_cases_array.each do |country|
      puts "     #{country.country}: #{country.total_confirmed} total cases".light_cyan
    end
  end

  # prints out the countries with the most new cases
  def self.most_new_cases
    most_new_cases_array = []

    sorted_array = CovidTracking::CountrySummary.all.sort_by {|country| country.new_confirmed}
    most_new_cases_array = sorted_array.select {|c| c.new_confirmed == sorted_array.last.new_confirmed}

    most_new_cases_array.each do |country|
      puts "     #{country.country}: #{country.new_confirmed} new cases".light_cyan
    end
  end

  # prints out the countries with the most recovered cases
  def self.most_recovered_cases
    most_rec_cases = []

    sorted_array = CovidTracking::CountrySummary.all.sort_by {|country| country.total_recovered}
    most_rec_cases = sorted_array.select {|c| c.total_recovered == sorted_array.last.total_recovered}

    most_rec_cases.each do |country|
      puts "     #{country.country}: #{country.total_recovered} out of #{country.total_confirmed} total cases have recovered".light_cyan
    end
  end

end
