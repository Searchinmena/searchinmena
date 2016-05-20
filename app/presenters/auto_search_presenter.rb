class AutoSearchPresenter
  attr_accessor :results, :locale, :autocomplete_results

  LIMIT = A9n.items_in_autocomplete

  def initialize(results)
    self.results = results.results
    self.autocomplete_results = []
  end

  def as_json(*)
    {
      items: total_records
    }
  end

  def total_records
    return nil unless results.present?
    results.first.map do |rec|
      @autocomplete_results << response_params(rec)
                               .merge!(categories: child_categories(rec))
    end
    records_witout_categories
    autocomplete_results
  end

  def records_witout_categories
    unless @autocomplete_results.present? && @autocomplete_results.count > LIMIT
      results_without_categories = results.second
      unless results_without_categories.blank?
        results_without_categories.map do |rec|
          autocomplete_results << { id: rec.id, name: rec.name }
        end
      end
    end
  end

  def child_categories(data)
    unless data.type == 'Tag'
      data.sub_categories
    end
  end

  def response_params(res)
    { id: res.id, name: res.name }
  end
end
