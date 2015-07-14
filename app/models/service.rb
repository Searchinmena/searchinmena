class Service < ActiveRecord::Base
  belongs_to :category
  belongs_to :business

  belongs_to :fob_price_currency, class_name: "Translatable"
  belongs_to :fob_price_unit, class_name: "Translatable"
  belongs_to :supply_ability_unit, class_name: "Translatable"
  belongs_to :supply_ability_frequency, class_name: "Translatable"

  belongs_to :average_completion_time_unit, class_name: "Translatable"

  has_many :photos, class_name: "ServicePhoto", dependent: :delete_all
  has_many :service_attributes, dependent: :delete_all
  has_many :service_payment_terms, dependent: :delete_all
  has_many :payment_terms, through: :service_payment_terms,
                           dependent: :delete_all
end
