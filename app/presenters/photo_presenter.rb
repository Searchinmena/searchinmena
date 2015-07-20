class PhotoPresenter
  takes :photo

  def as_json(*)
    {
      thumb: photo.photo_url(:thumb),
      url: photo.photo_url
    }
  end
end
