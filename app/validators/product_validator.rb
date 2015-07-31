class ProductValidator < BusinessItemValidator
  def self.fields
    super + [:model_number, :brand_name, :min_order_quantity_number,
             :min_order_quantity_unit_id, :photos_count]
  end

  attr_accessor(*fields)

  validates :model_number, :brand_name, :min_order_quantity_number,
            length: { maximum: A9n.validations[:max_text_field_size] }
  validates :min_order_quantity_number,
            numericality: { greater_than: 0, only_integer: true,
                            allow_nil: true }

  validates :min_order_quantity_unit_id,
    presence: true,
    if: proc { |i| i.min_order_quantity_number.present? }

  validates :photos_count, numericality: {
                              greater_than_or_equal_to: A9n.validations[:min_business_item_photo_count].to_i,
                              less_than_or_equal_to:  A9n.validations[:max_business_item_photo_count].to_i }

end
