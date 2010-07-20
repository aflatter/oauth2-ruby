module OAuth2

  module Models

    module ActiveRecord

      class ClientApplication < ::ActiveRecord::Base
        self.set_table_name OAuth2::Server.configurations[:models][:client_application]
      end

    end

  end

end
