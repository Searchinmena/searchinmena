class UserValidator < BaseValidator
  def self.fields
    [:email, :password, :password_confirmation]
  end

  attr_accessor(*fields)

  validates :email, :password, :password_confirmation, presence: true
  validates :email, :password, :password_confirmation, length:
    { maximum: A9n.validations[:max_text_field_size] }
  validates :email, format: { with: A9n.validations[:email_format] }
  validates :password, confirmation: true
end
