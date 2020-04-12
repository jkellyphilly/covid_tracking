# This file defines what happens in the Command Line Interface.

class CovidTracking::CLI

  attr_accessor :data_loader

  def call
    puts "Welcome to the CoVid-19 Tracker program. I hope you are staying safe and healthy during these unprecedented times."
    load_data
  end

  # Make a call to the DataLoader class to load all of our information in.
  def load_data
    puts "I am loading the data for you now..."
    self.data_loader = CovidTracking::DataLoader.new
    sleep(2)
    self.data_loader.make_summaries
    program_run
  end
  
  # Refresh the data and clear out the Summary and CountrySummary 
  # class variables 
  def reload_data
    puts "Refreshing data now..."
    sleep(2)
    CovidTracking::Summary.reset 
    CovidTracking::CountrySummary.reset
    self.data_loader.reset
    program_run
  end 
  
  # Main user interaction 
  def program_run
    
    # TODO: update the time stamp of when this data was updated
    # Ask for user input and get it
    puts "Information is updated from the data source every 15 minutes - this information was last updated at XXX."
    puts "What would you like to learn more about - a GLOBAL summary of COVID-19 spread, or a summary for a specific COUNTRY?"
    puts "Tip: you can also REFRESH the program to see if data has been updated."
    puts "Please enter GLOBAL, COUNTRY, REFRESH, or EXIT."
    user_input = gets.strip.downcase
    
    until user_input == "exit"
      if user_input == "refresh"
        reload_data
      elsif user_input == "country"
        puts "Here's all of the countries that you can choose from: "
        sleep(1)
        CovidTracking::Country.print_all_list
        
        puts "Please enter a country's name or its 3-letter code (in all caps!) that you'd like to see more info on."
        
        user_country = gets.strip
        binding.pry
        sleep(1)
        # Ask the user if they'd like to keep data surfing
        puts "Would you like to keep learning more about COVID-19 spread?"
        user_input_again = gets.strip.downcase
        if user_input_again == "yes"
          program_run
        elsif user_input_again == "no"
          sign_off
          exit
        else
          puts "I didn't understand that command."
          puts "Please enter GLOBAL, COUNTRY, REFRESH, or EXIT."
        end
      elsif user_input == "global"
        CovidTracking::Summary.print_all
        sleep(3)

        # Ask the user if they'd like to keep data surfing
        puts "Would you like to keep learning more about COVID-19 spread?"
        user_input_again = gets.strip.downcase
        
        until user_input_again == "yes" || user_input_again == "no"
          puts "I didn't understand that command."
          puts "Please enter YES or NO"
          user_input_again = gets.strip.downcase
        end
        
        if user_input_again == "yes"
          puts "Back to the main program..."
          sleep(2)
          program_run
        else
          sign_off
        end
      else
        puts "I didn't understand that command."
        sleep(1)
        puts "Please enter GLOBAL, COUNTRY, REFRESH, or EXIT."
        user_input = gets.strip.downcase
        sleep(1)
      end
    end
    
    sign_off

  end
  
  # Helper method for asking if a user wants to continue browsing
  #def continue_browsing?
    
  #end

  # Exit the program 
  def sign_off
    puts "Thank you for using the COVID-19 Tracking App."
    puts "Please remember to wash your hands frequently and practice social distancing whenever possible!"
    exit
  end

end
