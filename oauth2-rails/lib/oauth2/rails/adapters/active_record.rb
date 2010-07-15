module OAuth2

  module Rails

    module Adapters

      class ActiveRecord < Base
        
        def initialize
          super
          @models = Hash.new
        end

        def create_authorization_code_grant(attributes)
          model(:authorization_code_grant).create(
            attributes.slice(:client, :user, :request_uri, :code)
          )
        end
        
        # create_table :oauth2_authorization_code_grants do |t|
        #   t.string :code
        #   t.string :redirect_uri
        #   t.integer :user_id
        #   t.integer :client_id
        # end
        
        protected
        
        def constantize_model(id)
          OAuth2::Rails.config.models[:models][id].to_s.camelize.constantize
        end
        
        def model(id)
          @models[id] ||= constantize_model(id)
        end

      end

    end

  end

end