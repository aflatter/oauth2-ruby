module OAuth2

  module Models
    
    class RecordNotFound < StandardError; end # :nodoc:
    
    autoload :ActiveRecord, 'oauth2/models/active_record'
  end

end
