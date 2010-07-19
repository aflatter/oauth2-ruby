require Gem.required_location('activerecord', 'active_record', Gem::Requirement.new('>= 3.0.0.beta'))

module OAuth2
  module Models
    
    module ActiveRecord
      autoload :Client, 'oauth2/models/active_record/client'
    end
    
  end
end