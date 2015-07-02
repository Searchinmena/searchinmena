class Tag < Translatable
  has_and_belongs_to_many :businesses, join_table: :businesses_tags
end
