class PhotoPresenter
  takes :photo, :repository

  def as_json(*)
    {
      thumb: repository.photo_url(photo, :thumb),
      bigger_thumb: repository.photo_url(photo, :bigger_thumb),
      url: repository.photo_url(photo)
    }
  end
end
