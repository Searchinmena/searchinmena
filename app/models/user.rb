class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable,
         omniauth_providers: [:facebook]

  enum category: [:seller, :buyer, :both]

  has_one :business

  def self.category_name(type)
    I18n.t("user.types.#{type}")
  end
end
