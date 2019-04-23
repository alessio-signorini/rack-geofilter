# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rack/geofilter/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-geofilter"
  spec.version       = Rack::Geofilter::VERSION
  spec.authors       = ["Alessio Signorini"]
  spec.email         = ["alessio@signorini.us"]

  spec.summary       = %q{A rack middleware for blocking requests using Cloudflare IP Geolocation}
  spec.homepage      = "http://github.com/alessio-signorini/rack-geofilter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17.1"
  spec.add_development_dependency "rake", "~> 12.3.2"
  spec.add_development_dependency "minitest", ">= 5.11"
  spec.add_development_dependency "minitest-reporters", ">= 1.2"
end
