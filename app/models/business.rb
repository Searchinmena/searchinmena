class Business < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :business_types,
                          join_table: "businesses_business_types"
  has_many :products
end
