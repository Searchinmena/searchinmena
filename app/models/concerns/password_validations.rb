module PasswordValidations
  extend ActiveSupport::Concern

  included do
    validates :password, confirmation: true
    validates :password, length: { in: A9n.validations[:password_min_length]..
                                  A9n.validations[:password_max_length] }
  end
end

