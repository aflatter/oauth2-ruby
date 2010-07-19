class HttpContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value == "application/x-www-form-urlencoded"
      record.errors[attribute] = 'invalid-request'
    end
  end
end