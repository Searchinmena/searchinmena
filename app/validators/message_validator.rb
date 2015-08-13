MessageValidator = Struct.new(:subject, :body) do
  include ActiveModel::Validations

  validates :subject, :body, presence: true
  validates :subject, length:
    { maximum: A9n.validations[:max_text_field_size] }
  validates :body, length:
    { maximum: A9n.validations[:max_text_area_size] }
end

