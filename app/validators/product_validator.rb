class ProductValidator < BaseValidator
  def self.fields
    [:name, :model_number, :brand_name, :min_order_quantity_number,
     :min_order_quantity_unit, :fob_price, :fob_price_currency, :fob_price_unit,
     :port, :payment_terms, :supply_ability_capacity, :supply_ability_unit,
     :supply_ability_frequency, :supply_ability_unit,
     :supply_ability_frequency, :packaging_details, :description, :category_id]
  end

  attr_accessor(*fields)

  validates :name, :category_id, presence: true
  validates :name, :model_number, :brand_name, :min_order_quantity_number,
            :min_order_quantity_unit, :fob_price, :fob_price_currency,
            :fob_price_unit, :port, :payment_terms, :supply_ability_capacity,
            :supply_ability_unit, :supply_ability_frequency,
            :packaging_details,
            length: { maximum: A9n.validations[:max_text_field_size] }
  validates :description,
            length: { maximum: A9n.validations[:max_text_area_size] }
  validates :model_number, :category_id, :min_order_quantity_number,
            :supply_ability_capacity,
            numericality: { only_integer: true }
  validates :fob_price,
            numericality: { greater_than: 0 },
            format: { with: /#{A9n.validations[:price_format]}/ }
end
