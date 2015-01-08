require 'thor'

module NFPerformance
  class CLI < Thor


    desc "flood DOMAIN", "run flood using our test plan and options"
    method_option :ramp, type: :numeric, required: true
    method_option :users, type: :numeric, required: true
    method_option :length, type: :numeric, required: true
    method_option :region, type: :string, required: true
    method_option :name, type: :string

    def flood test_plan_name, domain
      test_plan = NFPerformance::Test.find_by_name(test_plan_name).new(options)
      test_plan.flood domain
    end

    desc "jmeter DOMAIN", "run jmeter using our test plan and options"
    method_option :ramp, type: :numeric, required: true
    method_option :users, type: :numeric, required: true
    method_option :length, type: :numeric, required: true
    method_option :name, type: :string

    def jmeter test_plan_name, domain
      test_plan = NFPerformance::Test.find_by_name(test_plan_name).new(options)
      test_plan.jmeter domain
    end
  end
end
