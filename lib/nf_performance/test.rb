require 'ruby-jmeter'

module NFPerformance
  class Test
    def initialize options = {}
      @users = options[:users]
      @ramp = options[:ramp]
      @length = options[:length]
      @domain = options[:domain]
      @region = options[:region]
      @name = options[:name]
    end

    def run
      a = test do
        grab_dsl self
        defaults(
          domain: @domain,
          protocol: 'http',
          image_parser: true,
          concurrentDwn: true,
          concurrentPool: 4
        )

        cache
        cookies

        plan
      end.grid ENV['FLOOD_IO_KEY'], region: @region, name: @name
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
