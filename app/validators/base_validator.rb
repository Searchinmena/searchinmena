class BaseValidator
  include ActiveModel::Validations
  extend Dependor::Injectable

  def initialize(record_params = {})
    self.class.fields.each do |field|
      val = record_params[field]
      send("#{field}=", val)
    end
  end

  def field(key)
    key
  end

  def errors?
    errors.present?
  end

  def copy_errors(record)
    errors.each do |key, error|
      record.errors.add(field(key), error)
    end
  end
end

