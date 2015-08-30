# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wp2hatena/version'

Gem::Specification.new do |spec|
  spec.name          = "wp2hatena"
  spec.version       = Wp2hatena::VERSION
  spec.authors       = ["utahta"]
  spec.email         = ["labs.ninxit@gmail.com"]

  spec.summary       = %q{convert images of wordpress to hatena blog}
  spec.description   = %q{convert images of wordpress to hatena blog}
  spec.homepage      = "https://github.com/utahta/wp2hatena.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'oauth', '~> 0.4.7'
  spec.add_dependency 'sinatra', '~> 1.4.6'

end
