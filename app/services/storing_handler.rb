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
    success = if errors?
                copy_errors
                false
              else
                repository.save(record)
                true
              end

    Response.new(success: success, object: record)
  end

  def assign_attributes
    record.assign_attributes(record_params)
  end

  def validate
    validator.valid?
  end

  def errors?
    validator.errors?
  end

  def copy_errors
    validator.copy_errors(record)
  end
end

