require Gem.required_location('activerecord', 'active_record', Gem::Requirement.new('>= 3.0.0.beta'))

module OAuth2

  module Models

    module ActiveRecord
      ::ActiveRecord::Base.establish_connection OAuth2::Server.configurations[:database]

      autoload :ClientApplication, 'oauth2/models/active_record/client_application'
    end

  end

end
