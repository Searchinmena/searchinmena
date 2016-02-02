module SearchableByCountry
  def where_country(results, country)
    results.where("country_id = ?", country)
  end
end
