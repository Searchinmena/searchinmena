class BaseValidator
  include ActiveModel::Validations
  extend Dependor::Injectable

  def injector
    @injector ||= ValidatorsInjector.new
  end

  def initialize(record_params = {})
    self.class.fields.each do |field|
      val = record_params[field]
      send("#{field}=", val)
    end
  end

  def field(key)
    key
  end
end

