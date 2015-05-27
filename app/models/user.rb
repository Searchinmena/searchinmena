class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum category: [:seller, :buyer, :both]

  has_one :business

  validates :category, presence: true

  def self.category_name(type)
    I18n.t("user.types.#{type}")
  end
end
