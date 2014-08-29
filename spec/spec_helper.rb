Dir['./spec/support/**/*.rb'].map { |f| require f }

require "pry"
require "race_condition/rspec"

RaceCondition::RSpec.configure do |c|
  c.report_if = ENV["CI"]
  c.codebase_id = ENV["CODEBASE_ID"]
  c.branch_name = ENV["TRAVIS_BRANCH"]
  c.commit = ENV["TRAVIS_COMMIT"]
  c.build_number = ENV["TRAVIS_BUILD_NUMBER"]
end

RSpec.configure do |c|
end
