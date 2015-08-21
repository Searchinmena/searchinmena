class SearchResultsPresenter
  attr_accessor :result_presenter_factory, :results, :page, :locale

  LIMIT = A9n.items_per_page

  def initialize(result_presenter_factory, results, page, locale)
    self.result_presenter_factory = result_presenter_factory
    self.results = results
    self.page = page.present? ? page.to_i : 1
    self.locale = locale
  end

  def as_json(*)
    {
      items: present_paginated,
      count: results.count
    }
  end

  def present_paginated
    offset = (page - 1) * LIMIT
    paginated = results.order(created_at: :desc).limit(LIMIT).offset(offset)
    paginated.map do |result|
      result_presenter_factory.build(result, locale)
    end
  end
end
