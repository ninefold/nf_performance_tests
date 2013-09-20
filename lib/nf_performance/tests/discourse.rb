module NFPerformance::Tests

  class Discourse < NFPerformance::Test
    def plan
      threads @users, {ramp_time: @ramp, duration: @length, scheduler: true, continue_forever: true} do
        # cache clear_each_iteration: true
        # A random timer to simulate user think-time
        random_timer 5000, 10000

        transaction '01_GET_home_page' do
          visit '/' do
            extract regex: 'href="(/t/[\w\-]+/\d+)"', name: 'post', match_number: 0
          end
        end

          transaction '02_GET_random_post' do
            visit '${post}'
          end

        transaction '03_GET_categories_page' do
          visit '/categories' do
            extract regex: 'href="(/category/category\d+)"', name: 'category', match_number: 0
          end
        end

          transaction '03_GET_random_category' do
            visit '${category}'
          end
      end
    end
  end
end
