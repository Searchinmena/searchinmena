# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sim/importer/version'

Gem::Specification.new do |spec|
  spec.name          = "sim-importer"
  spec.version       = Sim::Importer::VERSION
  spec.authors       = ["Ania Slimak"]
  spec.email         = ["anna.slimak@lunarlogic.io"]
  spec.license       = "private property of Sim"
  spec.homepage      = "http://nohomepage.org"

  spec.summary       = "Private gem for importing data from old SIM site"
  spec.description   = "Really nothing more"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|sim-importer.*)})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "pg", '~> 0.18', '>= 0.18.2'
  spec.add_dependency "mysql2", '~> 0.3', '>= 0.3.19'
  spec.add_dependency "activerecord", '~> 4.0', '>= 4.0.0'
  spec.add_dependency "bcrypt", '~> 3.1.10', '>= 3.1.10'
end
