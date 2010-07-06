module OAuth2

  module Rails

    module Adapters

      module ActiveRecord < Base

      end

    end

  end

end

@adapter = Class.new(OAuth2::Rails::Adapter) do
  %w{client user}.each do |model|
    adapter = OAuth2::Rails.models[model][:adapter].to_s.camelize
    klass   = OAuth2::Rails.models[model][:klass].to_s.camelize.constantize
    include "OAuth2::Rails::Adapters::#{adapter}::#{model}".camelize.constantize
    
    self.send "#{model}_klass=".to_sym, klass
  end
end

OAuth2::Rails.setup do |config|
  
  # Override the default adapter. By default, it is set to your current ORM.
  config.adapter = :active_record
  
  # Override 
  config.models[:client] = :client
  
  # Namespaced model and adapter names
  config.models[:client] = :'my/client'
  config.adapter = :'my/active_record'
  
end