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
  require 'factory_girl'
  require 'database_cleaner'
rescue LoadError => e
  puts 'One or more gems not found. Please run the command bundle install'
end

Dir.glob(File.join(File.dirname(__FILE__), 'factories', '**', '*_factory.rb')).each do |file|
  require file
end

Rspec.configure do |config|
  config.debug = true
  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
