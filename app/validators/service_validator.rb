class ServiceValidator < BusinessItemValidator
  def self.fields
    super + [:place_of_origin,
             :scope_of_work,
             :average_completion_time,
             :photos_count]
  end

  attr_accessor(*fields)

  validates :place_of_origin, :average_completion_time,
            length: { maximum: A9n.validations[:max_text_field_size] }
  validates :scope_of_work,
            length: { maximum: A9n.validations[:max_text_area_size] }
  validates :average_completion_time,
            numericality: {
              greater_than: 0,
              less_than_or_equal_to: A9n.validations[:max_integer],
              only_integer: true,
              allow_nil: true
            }

  min_photos = A9n.validations[:min_business_item_photo_count].to_i
  max_photos = A9n.validations[:max_business_item_photo_count].to_i

  validates :photos_count,
    numericality: {
      greater_than_or_equal_to: min_photos,
      less_than_or_equal_to:  max_photos
    }
end
