class StoringHandler
  attr_reader :record, :record_params, :repository, :validator

  def initialize(record, record_params, repository, validator)
    @record = record
    @record_params = record_params
    @repository = repository
    @validator = validator
  end

  def perform
    assign_attributes
    validate
    success = if no_errors?
                repository.save(record)
                true
              else
                copy_errors
                false
              end

    Response.new(success: success, object: record)
  end

  def assign_attributes
    record.assign_attributes(record_params)
  end

  def validate
    validator.valid?
  end

  def no_errors?
    validator.errors.empty?
  end

  def copy_errors
    validator.errors.each do |key, error|
      record.errors.add(validator.field(key), error)
    end
  end
end

