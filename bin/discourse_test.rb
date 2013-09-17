require 'bundler'

require_relative '../lib/nf_performance'
require_relative '../lib/nf_performance/tests/discourse'

class DiscourseTest < NFPerformance::CLI

  no_commands do
    def test_plan
      NFPerformance::Tests::Discourse.new options
    end
  end

end

DiscourseTest.start

