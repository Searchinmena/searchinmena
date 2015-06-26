class ProductValidator < BaseValidator
  def self.fields
    [:name, :model_number, :brand_name, :description, :category_id]
  end

  attr_accessor(*fields)

  validates :name, :model_number, :brand_name,
            :description, :category_id, presence: true
  validates :name, :model_number, :brand_name,
            length: { maximum: A9n.validations[:max_text_field_size] }
  validates :description,
            length: { maximum: A9n.validations[:max_text_area_size] }
  validates :model_number,
            numericality: { only_integer: true }
end
