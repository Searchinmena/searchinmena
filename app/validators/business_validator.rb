class BusinessValidator < BaseValidator
  def self.fields
    [:name, :country_id, :phone, :business_type_ids]
  end

  attr_accessor(*fields)

  validates :name, :country_id, :phone, :business_type_ids, presence: true
  validates :name, :country_id, :phone, length:
    { maximum: A9n.validations[:max_text_field_size] }
end
