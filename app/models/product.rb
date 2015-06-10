class Product < ActiveRecord::Base
  belongs_to :business
  has_many :photos
  has_many :attributes
  has_and_belongs_to_many :categories

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :attributes, allow_destroy: true
end
