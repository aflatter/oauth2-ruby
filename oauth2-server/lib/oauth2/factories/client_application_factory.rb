module OAuth2

  module Factories

    class ClientApplicationFactory < Base

      def self.find_by_external_id(external_id)
        OAuth2::Models::ActiveRecord::ClientApplication.find_by_external_id(external_id)
      end

    end

  end

end
