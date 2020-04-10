# This file defines what happens in the Command Line Interface.

class CovidTracking::CLI

  attr_accessor :current

  def call
    puts "Welcome to the CoVid-19 Tracker program. I hope you are staying safe and healthy during these unprecedented times."
    load_data
  end

  # Make a call to the DataLoader class to load all of our information in.
  def load_data
    puts "I am loading the data for you now..."
    self.current = CovidTracking::DataLoader.new
    sleep(2)
    self.current.make_summaries
    binding.pry
    program_run
  end
  
  # Main user interaction 
  def program_run
    
    # Ask for user input and get it
    puts "Information is updated from the data source every 15 minutes - this information was last updated at XXX."
    puts "What would you like to learn more about - a GLOBAL summary of COVID-19 spread, or a summary for a specific COUNTRY?"
    puts "Tip: you can also REFRESH the program to see if data has been updated."
    #puts "Please enter GLOBAL, COUNTRY, REFRESH, or EXIT."
    #user_input = gets.strip.downcase
    
    until user_input == "exit"
      puts "Please enter GLOBAL, COUNTRY, REFRESH, or EXIT."
      user_input = gets.strip.downcase
      if user_input == "refresh"
        load_data
      elsif user_input == "country"
        puts "Here's all of the countries that you can choose from: "
        sleep(1)
        # Print the list of countries and stuff
        puts "List of countries!!"
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
        puts "Global information on COVID-19 is: "
        puts self.current.data

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
          # should loop back around to see if I want to re-update my answer
          puts "I didn't understand that command."
        end
      elsif user_input == "exit"
        sign_off
        exit
      else
        puts "I didn't understand that command."
        sleep(1)
      end
      
      puts "Is this ever reached?"
    end

  end

  def sign_off
    puts "Thank you for using the COVID-19 Tracking App."
    puts "Please remember to wash your hands frequently and practice social distancing whenever possible!"
  end

end
