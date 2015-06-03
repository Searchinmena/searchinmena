class Api::TagPresenter
  takes :tag

  def as_json(*)
    {
      name: tag.name
    }
  end
end
