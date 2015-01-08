Ninefold Performance Tests
==========================

Ninefold's performance tests have been designed to show the impact on 
["happy users"](https://help.ninefold.com/entries/22413845-Apdex-to-Measure-User-Satisfaction) as different platforms scale.

These are the tests we ran to produce the data shown on [our performance
page](http://ninefold.com/performance). We wanted to release them so you can reproduce what we did and run your own tests.

Running the Tests
-----------------

The tests use the [ruby-jmeter](https://github.com/flood-io/ruby-jmeter) gem to
write a JMeter test plan which is then sent to [flood.io](http://flood.io). You
can set up your own JMeter install if you'd prefer, but flood is a great way to
get to the testing without messing around with setting up infrastructure.

Fork the repo and setup your environment:   
```
$ git clone https://github.com/ninefold/nf_performance_tests.git
$ cd nf_performance_tests
$ bundle install
```

If you're using flood, then you'll need to sign up and get your API token. You
can get that by going to [your flood settings page](https://flood.io/dashboard/settings)
and copying the token.

```
$ export FLOOD_IO_KEY=<your flood.io key>
```

Now you'll need to have a [Spree](http://spreecommerce.com) install with
the sample data loaded to point the test script at. We've got [a
repo](https://github.com/ninefold/nf_performance_spree) which you can fork and work
with. Instructions for setup are in that repo.

Once you've got your app running, time to point your flood at the app. Make sure
you've got a grid started in the region that you're going to flood from. If you
don't, you'll get a 400 error.

```
$ bundle exec ruby bin/spree_test.rb flood Spree <DOMAIN> --users=200 --ramp=60 \
                                                 --length=300 --region=us-west-1 --name="My Test"
```
Note that DOMAIN should not contain http:// or the trailing /.

If all went well, you should see a URL to your flood and you can watch it go and
see your results. We recommend setting the Apdex settings in flood.io to
something no more than 750ms for Satisfied and 3000ms for Tolerating.

Writing Your Own
----------------

We're working on a better API at the moment, but for now here are the steps to
create your own tests:

1. Copy `lib/nf_performance/tests/example.rb` and name it after your app (eg.
   `myapp.rb`. The app name must be the lowercase version of the class, without underscores)
2. Open your new test and rename the class `Example` to your app (eg. MyApp)
3. Using the [ruby-jmeter](https://github.com/flood-io/ruby-jmeter) DSL,
   write a test plan to simulate users.
4. Run your tests like the example for spree:

```
$ bundle exec bin/test.rb MyApp <DOMAIN> --users=200 --ramp=60 --length=300 \
                                         --region=us-west1 --name 'MyApp Test'
```


Contributing
------------
If you want to contribute to this repo, either by improving the tests or adding
a new project to test against, then you know the drill:

1. Fork the project
2. Make your changes
3. Make a pull request

Easy, n'est-ce pas?

Your Results
------------
We want to hear about your results. If your app doesn't perform the way that you
think it should on Ninefold, [then we want to know about it](http://ninefold.com/contact/). We're constantly
tweaking our platform to provide the best performance for the price.
