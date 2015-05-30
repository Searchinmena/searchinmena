class Registration::StoringHandler < BaseService
  attr_accessor :validator, :storing_handler

  def valid?
    validator.valid?
  end

  def perform
    storing_handler.perform
  end
end
