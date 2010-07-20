$LOAD_PATH.unshift(File.expand_path(File.join('..', '..', 'oauth2-core', 'lib'),
                                    File.dirname(__FILE__)))

require 'rubygems'
require 'oauth2/server'

begin
  require "bundler"
  Bundler.setup
rescue LoadError => e
  puts 'Bundler not found. Please install bundler with the command gem install bundler'
end

begin
  require 'rspec'
  require 'rspec/autorun'
rescue LoadError => e
  puts 'RSpec not found. Please run the command bundle install'
end

begin
  require 'factory_girl'
rescue LoadError => e
  puts 'factory_girl not found. Please run the command bundle install'
end

Dir.glob(File.join(File.dirname(__FILE__), 'factories', '**', '*_factory.rb')).each do |file|
  require file
end

Rspec.configure do |config|
  config.debug = true
  config.mock_with :rspec
end
