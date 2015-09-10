class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :confirmable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  enum category: [:seller, :buyer, :both]

  has_many :businesses, dependent: :delete_all

  validates_confirmation_of :password

  def self.category_name(type)
    I18n.t("user.categories.#{type}")
  end

  def can_see_business_items?
    seller? || both?
  end
end
