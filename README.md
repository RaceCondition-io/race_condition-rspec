# RaceCondition::Rspec [![Build Status](https://travis-ci.org/RaceCondition-io/race_condition-rspec.svg?branch=master)](https://travis-ci.org/RaceCondition-io/race_condition-rspec)

RSpec client for sending test suite results to RaceCondition.

## Installation

Add this line to your application's Gemfile:

    gem 'race_condition-rspec', require: false

And then execute:

    $ bundle


## Usage

Within your `spec_helper.rb`, require `race_condition/rspec` and configure it for your CI.

```ruby
require "race_condition/rspec"

RaceCondition::RSpec.configure do |c|
  c.report_if = ENV["CI"]
  c.codebase_id = ENV["CODEBASE_ID"]
  c.branch_name = ENV["TRAVIS_BRANCH"]
  c.commit = ENV["TRAVIS_COMMIT"]
  c.build_number = ENV["TRAVIS_BUILD_NUMBER"]
end
```

* `report_if` - This is a boolean or lambda that tells the reporter if it should test suite results to the server.  Most popular CI servers set the `CI` environment variable.
* `codebase_id` - This is the codebase ID from RaceCondition that you want to send the results to.
* `branch_name` - The current branch name (optional, but recommended).
* `commit` - The commit under test (optional).
* `build_number` - The CI's build number (optional).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/race_condition-rspec/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
