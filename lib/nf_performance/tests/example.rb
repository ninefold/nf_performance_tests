module NFPerformance::Tests

  # Rename your class to something relevant (eg. MyApp)
  class Example < NFPerformance::Test
    def plan
      # Replace this with a test plan for your app.
      threads @users, {ramp_time: @ramp, duration: @length, scheduler: true, continue_forever: true} do
        # A random timer to simulate user think-time
        random_timer 5000, 10000

        transaction '01_GET_home_page' do
          visit '/'
        end
      end
    end
  end
end
