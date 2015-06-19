class ProductValidator < BaseValidator
  def self.fields
    [:name, :model_number, :brand_name, :description, :category_id]
  end

  attr_accessor(*fields)

  validates :name, :model_number, :brand_name,
            :description, :category_id, presence: true
end
