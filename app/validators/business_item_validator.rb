class BusinessItemValidator < BaseValidator
  MAX_NAME_LENGTH = 130

  def self.fields
    [:name, :fob_price, :fob_price_currency_id, :fob_price_unit_id, :port,
     :supply_ability_capacity, :supply_ability_unit_id,
     :supply_ability_frequency_id, :packaging_details, :description,
     :category_id]
  end

  attr_accessor(*fields)

  validates :name, :category_id, presence: true
  validates :name, length: { maximum: A9n.validations[:max_name_length]  }
  validates :fob_price, :port, :supply_ability_capacity,
            :packaging_details,
            length: { maximum: A9n.validations[:max_text_field_size] }
  validates :description,
            length: { maximum: A9n.validations[:max_text_area_size] }
  validates :supply_ability_capacity,
    numericality: {
      greater_than: 0,
      less_than_or_equal_to: A9n.validations[:max_integer],
      only_integer: true,
      allow_nil: true
    }
  validates :fob_price,
            numericality: { greater_than: 0 },
            format: { with: /#{A9n.validations[:price_format]}/ },
            allow_nil: true

  validates :fob_price_unit_id, :fob_price_currency_id,
    presence: true, if: proc { |i| i.fob_price.present? }

  validates :supply_ability_unit_id, :supply_ability_frequency_id,
    presence: true, if: proc { |i| i.supply_ability_capacity.present? }
end
