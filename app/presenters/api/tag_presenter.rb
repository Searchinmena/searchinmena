class Api::TagPresenter
  takes :tag

  def as_json(*)
    {
      text: tag.name
    }
  end
end
