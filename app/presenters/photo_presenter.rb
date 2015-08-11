class PhotoPresenter
  takes :photo, :repository

  def as_json(*)
    {
      thumb: repository.photo_url(photo, :thumb),
      url: repository.photo_url(photo)
    }
  end
end
