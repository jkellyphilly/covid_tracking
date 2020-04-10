# Parent class for all summaries

class Summary
  
  attr_accessor :name, :new_confirmed, :total_confirmed, :new_deaths, :total_deaths, :new_recovered, :total_recovered, :date 
  
  def initialize
    puts "I've instantiated an instance of Summary."
  end
  
end