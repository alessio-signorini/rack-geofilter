# Rack::Geofilter

A simple gem to block traffic from unauthorized countries. Useful in case your
service is not available in those countries or if you are under attack.

It currently relies on the ``CF-IPCountry`` added by **[Cloudflare](https://support.cloudflare.com/hc/en-us/articles/200168236-What-does-Cloudflare-IP-Geolocation-do-)** firewall.

If you do not use that service you can not use this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-geofilter'
```

And then execute:

    $ bundle install

## Usage

To use with Rails, add to your ``config/application.rb`` the following line

```ruby
config.middleware.insert_before ActionDispatch::RemoteIp, Rack::Geofilter
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alessio-signorini/rack-geofilter.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
