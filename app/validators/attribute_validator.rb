class AttributeValidator < BaseValidator
  def self.fields
    [:name, :value]
  end

  attr_accessor(*fields)
end
