class Business < ActiveRecord::Base
  has_and_belongs_to_many :tags

  enum types: [:manufacturer, :trading_company, :buying_office, :agent,
               :distributer, :goverment_entity, :association,
               :business_services, :other]
end
