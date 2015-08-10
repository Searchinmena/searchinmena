class BusinessValidator < BaseValidator
  def self.fields
    [:name, :country_id, :phone, :city, :business_type_ids, :year_registered,
     :no_of_employees, :address_line_1, :address_line_2, :introduction]
  end

  attr_accessor(*fields)

  validates :name, :country_id, :phone, :business_type_ids, presence: true
  validates :name, :city, length: { maximum: A9n.validations[:max_name_length] }
  validates :phone, length: { maximum: A9n.validations[:max_phone_length] }
  validates :address_line_1, :address_line_2, :no_of_employees,
            :year_registered,
            length: { maximum: A9n.validations[:max_text_field_size] }
  validates :introduction,
            length: { maximum: A9n.validations[:max_text_area_size] }
  validates :no_of_employees, :year_registered,
            numericality: { greater_than: 0, only_integer: true,
                            allow_nil: true }
end
