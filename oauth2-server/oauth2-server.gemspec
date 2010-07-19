# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "oauth2-server"
  s.version     = '1.0.0.beta.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alexander Flatter", "Diogo Almeida", "Miguel Teixeira"]
  s.email       = ["aflatter@farbenmeer.net", "diogo.almeida@gnomeslab.com", "miguel.teixeira@gnomeslab.com"]
  s.homepage    = ["http://github.com/aflatter/oauth2-ruby", "http://gnomeslab.com/"]
  s.summary     = ""
  s.description = ""

  s.required_rubygems_version = ">= 1.3.7"

  s.add_dependency(%q<activesupport>, [">= 3.0.0.beta"])
  s.add_dependency(%q<activemodel>, [">= 3.0.0.beta"])
  s.add_dependency(%q<oauth2-core>, [">= 0.1.4"])

  s.add_development_dependency "rspec"

  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
end
