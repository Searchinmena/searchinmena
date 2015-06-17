class Api::TranslatablePresenter
  takes :translatable

  def as_json(*)
    {
      id: translatable.id,
      label: translatable.translations.first.value
    }
  end
end
