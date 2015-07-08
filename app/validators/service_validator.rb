class ServiceValidator < BusinessItemValidator
  def self.fields
    super + [:place_of_origin, :scope_of_work, :average_completion_time]
  end

  attr_accessor(*fields)

  validates :place_of_origin, :average_completion_time,
            length: { maximum: A9n.validations[:max_text_field_size] }
  validates :scope_of_work,
            length: { maximum: A9n.validations[:max_text_area_size] }
  validates :average_completion_time,
            numericality: { greater_than: 0, only_integer: true,
                            allow_nil: true }
end

