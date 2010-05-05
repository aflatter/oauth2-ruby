require 'active_support/concern'
require 'active_support/core_ext/class/inheritable_attributes'

module OAuth2
  
  module Attributes
    
    extend ActiveSupport::Concern
    
    included do
      class_inheritable_array :attribute_names
      self.attribute_names = Array.new
    end
    
    def attributes
      @attributes ||= Hash.new
    end
    
    module ClassMethods
      
      # Defines a callback for a handle.
      def attribute(handle)
        attribute_names << handle.to_sym
        
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def #{handle}(&block)
            @attributes ||= {}

            if block_given?
              @attributes[:#{handle}] = block
              return
            end

            if value = @attributes[:#{handle}]
              value.is_a?(Proc) ? value.call : value
            else
              raise "No attribute or callback for '#{handle}' defined"
            end
          end
          
          def #{handle.to_s.gsub('?', '')}=(value)
            @attributes ||= {}
            @attributes[:#{handle}] = value
          end
        EOS
      end
      
      def attributes(*handles)
        handles.each do |handle|
          attribute(handle)
        end
      end
      
    end

  end
  
end