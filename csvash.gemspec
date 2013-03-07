# -*- encoding: utf-8 -*-
require File.expand_path('../lib/csvash/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "csvash"
  gem.authors       = ["Lukas Alexandre", "Uriel Juliatti"]
  gem.email         = ["lukasalexandre@me.com", "uriel.juliattivalle@gmail.com"]
  gem.description   = %q{Simplify CSV to Model mapping and vice versa.}
  gem.summary       = %q{Simplify CSV to Model mapping and vice versa.}
  gem.homepage      = "https://github.com/lukelex/csvash"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.version       = Csvash::VERSION

  gem.add_development_dependency 'rake'
end
