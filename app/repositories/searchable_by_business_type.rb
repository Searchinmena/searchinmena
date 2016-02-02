module SearchableByBusinessType
  def where_business_type(results, business_type)
    results.includes(:businesses_business_types)
      .where("business_type_id = ?", business_type)
      .references(:businesses_business_types)
  end
end
