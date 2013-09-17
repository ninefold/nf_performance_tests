module NFPerformance::Tests

  class Discourse < NFPerformance::Test
    def plan
      threads @users, {ramp_time: @ramp, duration: @length, scheduler: true, continue_forever: true} do
        # A random timer to simulate user think-time
        random_timer 5000, 10000

        transaction '01_GET_home_page' do
          visit '/' do
            extract regex: 'href="(/t/[\w\-]+/\d+)"', name: 'posts', match_number: -1
          end
        end

        foreach_controller inputVal: 'posts', returnVal: 'post' do
          transaction '02_GET_random_post' do
            visit '${post}'
          end
        end

        transaction '03_GET_categories_page' do
          visit '/categories' do
            extract regex: 'href="(/category/category\d+)"', name: 'categories'
          end
        end

        foreach_controller inputVal: 'categories', returnVal: 'category' do
          transaction '03_GET_random_category' do
            visit '${category}'
          end
        end
        view_results_tree
      end
    end
  end
end
