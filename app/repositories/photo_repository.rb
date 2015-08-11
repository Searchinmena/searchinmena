module PhotoRepository
  TMP_UPLOAD_DIR = "/uploads/tmp"

  def photo_url(photo, type = nil)
    return default_image_for(type) unless photo
    return tmp_photo_url(photo, type) unless photo.photo_url

    photo.photo_url(type)
  end

  private

  def tmp_photo_dir(photo)
    photo.photo_tmp.split("/").first
  end

  def tmp_photo_name(photo)
    photo.photo_tmp.split("/").second
  end

  def tmp_photo_url(photo, type = nil)
    name = tmp_photo_name(photo)
    name = type ? "#{type}_#{name}" : name
    "#{TMP_UPLOAD_DIR}/#{tmp_photo_dir(photo)}/#{name}"
  end

  def default_image_for(type)
    image = type ? "default-image-#{type}.png" : "default-image.png"
    ActionController::Base.helpers.asset_path(image)
  end
end
