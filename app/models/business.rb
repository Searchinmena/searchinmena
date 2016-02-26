class Business < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags, join_table: :businesses_tags
  has_and_belongs_to_many :business_types,
                          join_table: "businesses_business_types"
  has_many :products
  has_many :services
  belongs_to :country
  validates :name, presence: true
  has_many :photos, class_name: "BusinessPhoto", dependent: :delete_all

  mount_uploader :logo, LogoUploader
  store_in_background :logo
end
