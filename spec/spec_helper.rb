Dir['./spec/support/**/*.rb'].map { |f| require f }

require "pry"
require "race_condition/rspec"

RSpec.configure do |c|
end
