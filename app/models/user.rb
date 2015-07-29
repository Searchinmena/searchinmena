class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :validatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :confirmable, :omniauthable, omniauth_providers:
         [:facebook]

  enum category: [:seller, :buyer, :both]

  has_one :business, dependent: :delete

  # hate doing this, but it's needed for users/passwords controller -
  # devise standard update action and I think that
  # implementing custom action would be too much overkill
  # #developerplakaljakkomitowal
  include PasswordValidations

  def self.category_name(type)
    I18n.t("user.types.#{type}")
  end

  def can_see_business_items?
    seller? || both?
  end
end
