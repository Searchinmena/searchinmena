class UserValidator < BaseValidator
  def self.fields
    [:id, :email, :password, :password_confirmation, :category]
  end

  attr_accessor(*fields)

  validates :email, :password, :password_confirmation, :category, presence: true
  validates :email, :password, :password_confirmation, length:
    { maximum: A9n.validations[:max_text_field_size] }
  validates :email, format: { with: A9n.validations[:email_format] }
  validates :password, confirmation: true
  validates :password, length: { in: A9n.validations[:password_min_length]..
                                 A9n.validations[:password_max_length] }

  validate :uniqueness

  def uniqueness
    existing_count = User.where(email: email)
      .where.not(id: id).count

    if existing_count > 0
      error_message = I18n.t(
        "activerecord.errors.messages.uniqueness")
      errors[:email] << error_message
    end
  end
end
