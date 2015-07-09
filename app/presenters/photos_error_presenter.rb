class PhotosErrorPresenter
  takes :file, :response

  def as_json(*)
    {
      file_name: file.original_filename,
      errors: response.errors
    }
  end
end
