class Registration::BaseCreator < BaseService
  attr_accessor :validator, :storing_handler

  delegate :valid?, to: :validator
  delegate :perform, to: :storing_handler
end
