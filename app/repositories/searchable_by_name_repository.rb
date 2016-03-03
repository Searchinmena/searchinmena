module SearchableByNameRepository
  def where_name_like(type, keywords)
    # filter record by name and tags
    if keywords.present? && type == 'business'
      tag_arr = Tag.includes(:translations)
        .where("value ILIKE ?", "%#{keywords}%")
        .pluck('id')
      klass.includes(:businesses_tags)
        .where("name ILIKE ? or tag_id IN (?)",
               "%#{keywords}%", tag_arr).references(:businesses_tags)
    else
      klass.where("name ILIKE ?", "%#{keywords}%")
    end
  end
end
