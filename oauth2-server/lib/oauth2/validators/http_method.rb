class HttpMethodValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless (options[:method].is_a?(Array) && options[:method].include?(value)) || options[:method] === value
      record.errors[attribute] = 'invalid-request' unless options[:method] == value
    end
  end
end