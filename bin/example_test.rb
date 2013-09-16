require 'bundler'

require_relative '../lib/nf_performance'
require_relative '../lib/nf_performance/tests/example'

class ExampleTest < NFPerformance::CLI

  no_commands do
    def test_plan
      NFPerformance::Tests::Example.new options
    end
  end

end

ExampleTest.start

