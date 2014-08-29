require "race_condition/rspec.rb"

class RaceCondition::Client
  def report!(project, data)
    puts data.to_json
  end
end

RaceCondition::RSpec.configure do |c|
end

RSpec.configure do |c|
end
