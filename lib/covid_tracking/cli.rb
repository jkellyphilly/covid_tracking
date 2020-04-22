# This file defines what happens in the Command Line Interface.

class CovidTracking::CLI

  attr_accessor :data_loader

  # Welcome the user to the program and kick off the data load process
  def call
    puts "Welcome to the CoVid-19 Tracker program. I hope you are staying safe and healthy during these unprecedented times.".cyan
    sleep(1.5)
    load_data
  end

  # Make a call to the DataLoader class to load all of our information in
  def load_data
    puts "Loading data now...".cyan
    self.data_loader = CovidTracking::DataLoader.new
    sleep(1.5)
    puts "Data loaded. Making the summaries now...".cyan
    sleep(1.5)
    self.data_loader.make_summaries
    program_run
  end

  # Refresh the data and clear out the Summary and CountrySummary
  # class variables
  def reload_data
    puts "Refreshing data now...".cyan
    sleep(2)
    CovidTracking::Summary.reset
    CovidTracking::CountrySummary.reset
    self.data_loader.reset
    program_run
  end

  # Main user interaction
  def program_run

    print_main_user_options
    user_input = gets.strip.downcase

    until user_input == "exit"
      if user_input == "refresh"
        reload_data
      elsif user_input == "country"
        puts "Here's all of the countries and territories that you can choose from: ".light_magenta
        sleep(1)
        print_all_countries
        puts "Enter a country's name or 2-letter code for more info:".green

        # Let a user choose which country they want to learn more about
        # and then print that information
        print_country_info

        # Ask the user if they'd like to keep learning
        continue_browsing

      elsif user_input == "global"
        print_global_list
        sleep(2)

        # Ask the user if they'd like to keep learning
        continue_browsing

      elsif user_input == "factoids"
        print_factoids_options

        # Get user input and show the corresponding factoid
        print_factoids

        # Ask the user if they'd like to keep learning
        continue_browsing

      else
        puts "I didn't understand that command.".red
        sleep(1)
        puts "Please enter GLOBAL, COUNTRY, REFRESH, FACTOIDS, or EXIT.".green
        user_input = gets.strip.downcase
      end
    end

    sign_off

  end

  # --------------
  # HELPER METHODS
  # --------------

  def print_all_countries
    CovidTracking::CountrySummary.print_all_list
  end

  def print_global_list
    CovidTracking::Summary.print_all
  end

  # Gets a user's input and print's out the corresponding country's info
  def print_country_info
    country = []

    while country.size == 0
      user_country = gets.strip

      # If the user input is 2 characters long, it's a code
      if user_country.size == 2
        country = CovidTracking::CountrySummary.find_by_code(user_country)
      else
        country = CovidTracking::CountrySummary.find_by_name(user_country)
      end

      if country.size == 0
        puts "I can't find a country with that name or code.".red
        sleep(1)
        puts "Enter a country's name or 2-letter code for more info:".green
      else
        country.each {|c| c.print_info}
      end
    end
  end

  # Helper method to print the user's options at the top level
  def print_main_user_options
    puts "-------".light_magenta
    puts "Information is updated from the data source approximately every 15 minutes - this information was last updated at #{CovidTracking::Summary.all.first.date}.".light_magenta
    puts "-------".light_magenta
    puts "What would you like to learn more about - a GLOBAL summary of COVID-19 spread, or a summary for a specific COUNTRY?".light_magenta
    puts "Tip: you can also REFRESH the program to see if data has been updated or enter FACTOIDS for some summary facts.".light_magenta
    puts "Please enter GLOBAL, COUNTRY, REFRESH, FACTOIDS, or EXIT.".green
  end

  # Helper method for asking if a user wants to continue browsing
  def continue_browsing
    puts "Would you like to keep learning more about COVID-19 spread?".green
    user_input = gets.strip.downcase

    until user_input == "yes" || user_input == "no"
      puts "I didn't understand that command.".red
      puts "Please enter YES or NO".green
      user_input = gets.strip.downcase
    end

    user_input == "yes" ? program_run : sign_off
  end

  # Helper method for printing the factoids available for the user to view
  def print_factoids_options
    puts "Available factoids are: ".light_magenta
    puts "     Country/countries with the MOST cases".light_red
    puts "     Country/countries with the LEAST cases".light_red
    puts "     Country/countries with the MOST NEW cases".light_red
    puts "     Country/countries with the MOST RECOVERED cases".light_red
    puts "Which factoid would you like to see?".light_magenta
    puts "Please enter MOST, LEAST, MOST NEW, or MOST RECOVERED".green
  end

  # Get a user's input and print the corresponding factoid
  def print_factoids
    factoid_input = gets.strip.downcase

    case factoid_input
    when "most"
      puts "The country/countries with the most cases are: ".light_magenta
      CovidTracking::CountrySummary.most_cases
    when "least"
      puts "The country/countries with the least cases are: ".light_magenta
      CovidTracking::CountrySummary.least_cases
    when "most new"
      puts "The country/countries with the most new cases are: ".light_magenta
      CovidTracking::CountrySummary.most_new_cases
    when "most recovered"
      puts "The country/countries with the most recovered cases are: ".light_magenta
      CovidTracking::CountrySummary.most_recovered_cases
    else
      puts "I didn't understand that command.".red
      sleep(1)
    end
  end

  # Exit the program
  def sign_off
    puts "Thank you for using the COVID-19 Tracking App.".cyan
    puts "Please remember to wash your hands frequently and practice social distancing whenever possible!".cyan
    exit
  end

end
