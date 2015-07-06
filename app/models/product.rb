class Product < ActiveRecord::Base
  belongs_to :business
  belongs_to :category
  has_many :photos, class_name: 'ProductPhoto', dependent: :delete_all
  has_many :product_attributes, dependent: :delete_all
end
