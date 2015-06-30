class ErrorsPresenter
  takes :record

  def as_json(*)
    return {} unless record

    errors = record.errors.messages.map do |key, val|
      [key, val.first]
    end
    Hash[errors]
  end
end
