module OAuth2

  module Rails

    module Adapters

      class ActiveRecord < Base

        def create_authorization_code_grant(attributes)
          AuthorizationCodeGrant.create(
            attributes.slice(:client, :user, :request_uri, :code)
          )
        end

      end

    end

  end

end