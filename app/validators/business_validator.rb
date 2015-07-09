class BusinessValidator < BaseValidator
  def self.fields
    [:name, :country_id, :phone, :business_type_ids, :year_registered,
     :no_of_employees, :address_line_1, :address_line_2]
  end

  attr_accessor(*fields)

  validates :name, :country_id, :phone, :business_type_ids, presence: true
  validates :name, :country_id, :phone, :address_line_1, :address_line_2,
            length: { maximum: A9n.validations[:max_text_field_size] }
  validates :no_of_employees, :year_registered, numericality: { greater_than: 0,
                                                            only_integer: true,
                                                            allow_nil: true }
end
