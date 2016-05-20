class Tag < Translatable
  searchkick text_start: [:name]

  has_and_belongs_to_many :businesses, join_table: :businesses_tags

  def search_data
    { name: english_title }
  end
end
