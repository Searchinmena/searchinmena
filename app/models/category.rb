class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category', foreign_key: :parent_id

  has_many :translations, foreign_key: :key, primary_key: :key

  def parent?
    parent.nil?
  end
end
