# -*- encoding: utf-8 -*-
require File.expand_path('../lib/csvash/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "csvash"
  gem.authors       = ["Lukas Alexandre"]
  gem.email         = ["lukeskytm@gmail.com"]
  gem.description   = %q{Csvash automates your CSV extraction by mapping its headers with the columns contents and turning them into hashes that can be easily converted into ruby models.}
  gem.summary       = %q{Csvash automates your CSV extraction by mapping its headers with the columns contents and turning them into hashes that can be easily converted into ruby models.}
  gem.homepage      = "https://github.com/lukasalexandre/csvash"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.version       = Csvash::VERSION
end