class ProductValidator < BaseValidator
  def self.fields
    [:name, :model_number, :brand_name, :description, :category]
  end

  attr_accessor(*fields)

  validates :name, :model_number, :brand_name,
            :description, :category, presence: true
end
