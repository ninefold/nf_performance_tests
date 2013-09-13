require 'bundler'

require_relative '../lib/nf_performance'
require_relative '../lib/nf_performance/tests/spree'

class SpreeTest < NFPerformance::CLI

  no_commands do
    def test_plan
      NFPerformance::Tests::Spree.new options
    end
  end

end

SpreeTest.start
