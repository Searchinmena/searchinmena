class Service < ActiveRecord::Base
  searchkick text_start: [:name, :category_name]

  belongs_to :category
  belongs_to :business

  has_many :category_translations, through: :category, source: :translations

  belongs_to :fob_price_currency, class_name: "Translatable"
  belongs_to :fob_price_unit, class_name: "Translatable"
  belongs_to :supply_ability_unit, class_name: "Translatable"
  belongs_to :supply_ability_frequency, class_name: "Translatable"

  belongs_to :average_completion_time_unit, class_name: "Translatable"

  has_many :photos, class_name: "ServicePhoto", dependent: :delete_all
  accepts_nested_attributes_for :photos, allow_destroy: true
  has_many :service_attributes, dependent: :delete_all
  has_many :service_payment_terms, dependent: :delete_all
  has_many :payment_terms, through: :service_payment_terms,
                           dependent: :delete_all

  def search_data
    attributes.merge(
      category_name: category.english_title,
      feature: business.try(:feature),
      weight: business.try(:weight)
    )
  end
end
