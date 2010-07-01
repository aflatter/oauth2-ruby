# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
Gem::Specification.new do |s|
  s.name        = "oauth2-server"
  s.version     = '0.1.4'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alexander Flatter"]
  s.email       = ["aflatter@farbenmeer.net"]
  s.homepage    = "http://github.com/aflatter/oauth2"
  s.summary     = ""
  s.description = ""
 
  s.required_rubygems_version = ">= 1.3.6"
  
  s.add_dependency(%q<oauth2-core>, [">= 0.1.4"])
 
  s.add_development_dependency "rspec"
 
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
end
