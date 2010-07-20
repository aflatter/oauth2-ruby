require Gem.required_location('activerecord', 'active_record', Gem::Requirement.new('>= 3.0.0.beta'))
require 'oauth2/models/active_record/configurations'

module OAuth2
  module Models
    
    module ActiveRecord
      include Configurations

      autoload :Client, 'oauth2/models/active_record/client'
    end
    
  end
end