require 'active_record'

module OAuth2
  module Models
    
    module ActiveRecord
      autoload :Client, 'oauth2/models/active_record/client'
    end
    
  end
end