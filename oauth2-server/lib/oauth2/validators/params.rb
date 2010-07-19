class ParamsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] = 'invalid-request' unless value.is_a? Hash
  end
end