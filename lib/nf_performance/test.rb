require 'ruby-jmeter'

module NFPerformance
  class Test
    def initialize options = {}
      @users = options[:users]
      @ramp = options[:ramp]
      @length = options[:length]
      @region = options[:region]
      @name = options[:name]
    end

    def flood domain
      @domain = domain
      test_plan.grid ENV['FLOOD_IO_KEY'], region: @region, name: @name
    end

    def jmeter domain
      @domain = domain
      test_plan.run path: '/opt/boxen/homebrew/bin/', gui:true
    end

    def test_plan
      test do
        grab_dsl self
        defaults(
          domain: @domain,
          protocol: 'http',
          image_parser: true,
          concurrentDwn: true,
          concurrentPool: 4
        )

        cookies

        plan
      end
    end

    def plan
      raise "There is no plan!"
    end

    def grab_dsl dsl
      @dsl = dsl
    end

    def method_missing method, *args, &block
      @dsl.__send__ method, *args, &block
    end
  end
end
