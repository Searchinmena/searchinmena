class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category', foreign_key: :parent_id
  has_and_belongs_to_many :products

  default_scope { order("LOWER(name)") }

  def parent?
    parent.nil?
  end
end
