require 'oauth2/attributes'

module OAuth2

  module Headers

    class Authenticate

      Attributes = [
        :realm, :algorithms, :auth_uri, :token_uri, :error
      ]

      Attributes.each do |attribute|
        attr_accessor attribute
      end

      def valid?
        raise "Realm not set" unless realm

      end

      def to_hash
        Attributes.inject(Hash.new) do |hash, attribute|
          value = send(attribute)
          hash[attribute] = value unless value.nil?
          hash
        end
      end

      def to_s
        to_hash.collect do |key, value|
          name = key.to_s.gsub('_', '-')
          "#{name}='#{value}'"
        end.join(",\n      ")
      end

    end

  end

end