class Product < ActiveRecord::Base
  belongs_to :business
  has_and_belongs_to_many :categories
  has_many :product_photos
  has_many :product_attributes

  accepts_nested_attributes_for :product_photos, allow_destroy: true
  accepts_nested_attributes_for :product_attributes, allow_destroy: true
end
