class SearchResultsPresenter
  attr_accessor :result_presenter_factory, :results, :page, :locale, :count

  LIMIT = A9n.items_per_page

  def initialize(result_presenter_factory, results, page, locale, count = nil)
    self.result_presenter_factory = result_presenter_factory
    self.results = results
    self.page = page.present? ? page.to_i : 1
    self.locale = locale
    self.count = count
  end

  def as_json(*)
    {
      items: present_paginated,
      count: count
    }
  end

  def present_paginated
    # offset = (page - 1) * LIMIT
    ordered = results.to_a
    # .sort { |a,b|  a.created_at <=> b.created_at}
    paginated = ordered || []
    paginated.map do |result|
      result_presenter_factory.build(result, locale)
    end
  end
end
