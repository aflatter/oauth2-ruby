require 'oauth2/attributes'
require 'hmac-sha2'
require 'active_support/base64'

module OAuth2
  
  module Server
    
    class Request
      
      include OAuth2::Attributes
      
      attributes  :host, :realm, :algorithms, :method,
                  :request_header, :request_uri,
                  :host_with_port, :secret, :access_token,
                  :access_token_expired?

      class << self

        def validate(*args)
          request = new(*args)
          request.validate
          request
        end

      end
      
      def initialize(attributes = {}, &block)
        self.attributes.merge!(attributes)
        yield self if block_given?
      end
      
      def errors
        @errors ||= []
      end

      alias_method :original_request_header, :request_header

      # Overwrite attribute reader #request_header
      # See OAuth2::Core::Attributes
      def request_header(&block)
        value = original_request_header(&block)

        if value.is_a?(String)
          value = Headers::Authorization.parse(value)
        end

        value
      end

      def type
        return :bearer        if bearer?
        return :cryptographic if cryptographic?
        
        :unknown
      end
      
      def bearer?
        if request_header.attributes.values.compact.size != 1 
          return false
        end
        
        not request_header.token.nil?
      end
      
      def cryptographic?
        required_attributes = %w{token nonce timestamp algorithm signature}
        required_attributes.map! do |attribute|
          request_header.send(attribute.to_sym).nil?
        end

        required_attributes.uniq == [false]
      end

      # Calculates the header signature as described on:
      # http://tools.ietf.org/html/draft-hammer-oauth2-00#section-5.3.1
      def calculate_signature
        normalized_string = [
          request_header.timestamp,
          request_header.nonce,
          request_header.algorithm,
          method.upcase,
          host_with_port,
          request_uri
        ].join(',')

        digest = HMAC::SHA256.digest(secret, normalized_string)

        ActiveSupport::Base64.encode64s(digest)
      end

      def validate_signature
        if calculate_signature != request_header.signature
          errors << :signature_invalid
          return false
        end
        
        true
      end
      
      def validate_access_token
        unless access_token
          errors << :access_token_invalid
          return false
        end
        
        if access_token_expired?
          errors << :access_token_expired
          return false
        end
        
        true
      end
      
      def validate_request_header
        unless request_header
          errors << :missing_authorization_header
          return false
        end
        
        true
      end

      def validate
        errors.clear

        if validate_request_header
          validate_access_token
          validate_signature if type == :cryptographic
        end

        @valid = errors.empty?
      end
      
      def valid?
        @valid
      end

    end
    
  end
  
end