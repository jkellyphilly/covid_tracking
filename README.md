# CovidTracking

This gem uses the COVID19 API to return a summary of coronavirus cases throughout the world. A user is able to specify whether they'd like to view a summary of COVID data about the world, or whether they'd like to view a specific country's statistics. Users can also reload the data to see if the data has been refreshed or view some max/min statistics.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'covid_tracking'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install covid_tracking

## Usage

This application is user-interactive and is intended for users to become more informed of the statistics and spread of COVID-19. The code in the driver file (/lib/covid_tracking/cli.rb) prints out clear instructions to the user when input is required.

To run the program, first run 'bundle' from your command line. Assuming all gems are installed correctly, you're ready to run the program by running 'bin/covid_tracking' from your command line! 

Essentially, users are greeted and then given a choice to view global data, data about a specific country, refresh the data, or view specific facts that have helper methods to calculate. If the user selects to view information about a specific country, there is one more level deeper that the user is taken - the user is prompted to input the country's name or 2-letter code (the full list of countries with their codes are printed out before this prompt appears).

Check out this explanation on YouTube (it's a 3-part series of me explaning this code): https://www.youtube.com/watch?v=WtBNjnAgj3s

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'joel-kelly'/covid_tracking. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CovidTracking project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'joel-kelly'/covid_tracking/blob/master/CODE_OF_CONDUCT.md).
