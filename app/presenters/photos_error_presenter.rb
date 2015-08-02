class PhotosErrorPresenter
  takes :file, :response

  def as_json(*)
    {
      file_name: file.filename,
      errors: response.errors
    }
  end
end
