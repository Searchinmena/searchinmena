class BusinessType < Translatable
  has_and_belongs_to_many :businesses, join_table: "businesses_business_types"
end
