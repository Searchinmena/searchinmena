class BusinessItemValidator < BaseValidator
  def self.fields
    [:name, :fob_price, :port, :supply_ability_capacity, :packaging_details,
     :description, :category_id]
  end

  attr_accessor(*fields)

  validates :name, :category_id, presence: true
  validates :name, :fob_price, :port, :supply_ability_capacity, :packaging_details,
            length: { maximum: A9n.validations[:max_text_field_size] }
  validates :description,
            length: { maximum: A9n.validations[:max_text_area_size] }
  validates :supply_ability_capacity,
            numericality: { greater_than: 0, only_integer: true, allow_nil: true }
  validates :fob_price,
            numericality: { greater_than: 0, allow_nil: true },
            format: { with: /#{A9n.validations[:price_format]}/ }
end
