require 'oauth2/attributes'
require 'active_support/ordered_hash'

module OAuth2

  module Headers

    class Authorization

      def initialize(attributes = {})
        attributes.each_pair do |key, value|
          if Attributes.include?(key.to_sym)
            instance_variable_set("@#{key}", value)
          end
        end
      end

      # These attributes are expected to be contained in the header
      Attributes = [
        :token, :nonce, :timestamp, :algorithm, :signature
      ]

      Attributes.each do |attribute|
        attr_accessor(attribute)
      end
      
      def validate
        case request_type
        when :bearer
          @errors << :bearer_request_requires_token unless token
        when :cryptographic
          %w{nonce timestamp algorithm signature}.each do |attribute|
            unless instance_variable_get("@#{attribute}")
              error = "cryptographic_request_requires_#{attribute}".to_sym
              @errors << error
            end
          end
        end

        @errors.blank?     
      end
      
      def errors
        @errors ||= []
      end
      
      def attributes
        hash = ActiveSupport::OrderedHash.new
        Attributes.each do |attribute|
          hash[attribute] = instance_variable_get("@#{attribute}")
        end
        hash
      end
      
      def to_s
        attrs = attributes.collect do |key, value|
          %{#{key}="#{value}"} if value
        end.compact

        "Token " + attrs.join(",\n     ")
      end

      class << self

        # This method does what it is named after. Give it a String and it
        # returns a Hash. The header specification can be found on:
        # http://tools.ietf.org/html/draft-hammer-oauth2-00#section-5.1
        # TODO: Verify that token is the first attribute.
        def parse(string)
          header = new

          string.strip!

          type, tuples = string[0..4], string[5..-1].split("\n")

          unless type == "Token"
            header.errors << :format_invalid
            return header
          end
          
          tuples.map! { |tuple| tuple.strip! }
          
          tuples.each do |tuple|
            unless tuple =~ /\s*(.+)="(.+)"/
              header.errors << :format_invalid 
            else
              key, value = $1.to_sym, $2

              unless Attributes.include?(key)
                header.errors << "unknown_attribute_#{key}".to_sym
              else
                header.send("#{key}=".to_sym, value)
              end
            end
          end

          header
        end

      end

    end

  end

end