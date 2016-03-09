class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  enum category: [:seller, :buyer, :both]

  has_one :business, dependent: :delete

  validates_confirmation_of :password

  def self.category_name(type)
    I18n.t("user.categories.#{type}")
  end

  def can_see_business_items?
    seller? || both?
  end
end
