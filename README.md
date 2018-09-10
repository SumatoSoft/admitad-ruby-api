# Admitad

Link to api [https://developers.admitad.com/en/doc/](https://developers.admitad.com/en/doc/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'admitad'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install admitad

## Usage


### Configure your app


```ruby
# config/initializers/admitad.rb

Admitad.config do |c|
  c.client_id     = Rails.application.secrets.admitad[:client_id]
  c.client_secret = Rails.application.secrets.admitad[:client_secret]
  c.scope         = Rails.application.secrets.admitad[:scope]
end
```
If no scope is specified, will be used the whole

### Start to use

The best documentation is the source code. Use it in conjunction with the API documentation

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/admitad

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
