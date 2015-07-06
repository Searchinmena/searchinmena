class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :validatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :confirmable, :omniauthable, omniauth_providers:
         [:facebook]

  enum category: [:seller, :buyer, :both]

  has_one :business, dependent: :delete

  def self.category_name(type)
    I18n.t("user.types.#{type}")
  end
end
