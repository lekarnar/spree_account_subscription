Spree Account Subscription
==========================

## Installation

1. Add this extension to your Gemfile with this line:
  ```ruby
  gem 'spree_account_subscription', github: 'cehdeti/spree_account_subscription'
  ```

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Copy & run migrations
  ```ruby
  bundle exec rails g spree_account_subscription:install
  ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_account_subscription/factories'
```

## Contributing

Copyright (c) 2016 ETI, released under the New BSD License
