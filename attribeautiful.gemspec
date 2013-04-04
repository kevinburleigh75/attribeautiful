# -*- encoding: utf-8 -*-
require File.expand_path('../lib/attribeautiful/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Kevin Burleigh"]
  gem.email         = ["klb@kindlinglabs.com"]
  gem.description   = %q{Dynamically-generated HTML element attribute management methods}
  gem.summary       = %q{Dynamically-generated HTML element attribute management methods.
                         Easily add attributes to an element, or content to an attribute
                         value.}
  gem.homepage      = ""

  gem.add_dependency  "eager_beaver"
  gem.add_dependency  "active_support", ">= 3.0.0"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "attribeautiful"
  gem.require_paths = ["lib"]
  gem.version       = Attribeautiful::VERSION
end
