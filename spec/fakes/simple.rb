require_relative "spec_helper"

RSpec.describe 'group 1' do
  specify('group 1 example 1', type: "feature") {}
  specify('group 1 example 2') {}
  specify('group 1 example 3') {}
  describe 'group 1-1' do
    specify('group 1-1 example 1') {}
    specify('group 1-1 example 2') {}
    specify('group 1-1 example 3') {}
  end
end
