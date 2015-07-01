class BusinessValidator < BaseValidator
  def self.fields
    [:name, :country, :phone]
  end

  attr_accessor(*fields)

  validates :name, :country, :phone, presence: true
  validates :name, :country, :phone, length:
    { maximum: A9n.validations[:max_text_field_size] }
end
