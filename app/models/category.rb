class Category < ActiveRecord::Base
  has_and_belongs_to_many :products

  default_scope { order("LOWER(name)") }
end
