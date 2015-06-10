class Category < ActiveRecord::Base
  has_and_belongs_to_many :products
  belongs_to :parent, class_name: 'Category', foreign_key: :parent_id

  default_scope { order("LOWER(name)") }

  def parent?
    parent.nil?
  end
end
