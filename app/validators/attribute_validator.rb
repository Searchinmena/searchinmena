class AttributeValidator < BaseValidator
  def self.fields
    [:name, :value]
  end

  attr_accessor(*fields)

  validates :name, :value,
            length: { maximum: A9n.validations[:max_text_field_size] }

  validates :value,
            length: { minimum: 1, maximum: A9n.validations[:max_text_field_size] },
            presence: true, if: proc { |i| i.name.present? }

end
