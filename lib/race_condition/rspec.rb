require "race_condition/rspec/version"
require "race_condition/rspec/configuration"
require "race_condition/client"
require "race_condition/rspec/report"
require "race_condition/rspec/listener"

RSpec.configure do |config|
  config.reporter.register_listener(RaceCondition::RSpec::Listener.new,
                                    *RaceCondition::RSpec::Listener::SUBSCRIPTIONS)
end

module RaceCondition
  module RSpec
    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end
  end
end

