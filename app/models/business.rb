class Business < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags, join_table: :businesses_tags
  has_many :products
  has_many :services
  belongs_to :country

  enum business_type: [:manufacturer, :trading_company, :buying_office,
                       :agent, :distributor, :goverment_entity, :association,
                       :business_services, :other]
end
