require "race_condition/rspec.rb"

module RaceCondition
  class Client
    def report!(project_id, data)
      puts data.to_json
    end
  end
end

RaceCondition::RSpec.configure do |c|
end

RSpec.configure do |c|
end
