require 'thor'

module NFPerformance
  class CLI < Thor


    desc "flood URL", "run flood using our test plan and options"
    method_option :ramp, type: :numeric, required: true
    method_option :users, type: :numeric, required: true
    method_option :length, type: :numeric, required: true
    method_option :region, type: :string, required: true
    method_option :name, type: :string

    def flood url
      test_plan.run
    end

    no_commands do
    def test_plan
      # TODO: Meta-programming magic
      raise "No test plan defined"
    end
    end
  end
end
