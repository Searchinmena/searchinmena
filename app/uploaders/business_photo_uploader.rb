# encoding: utf-8

class BusinessPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay

  storage :fog

  process resize_to_limit: [A9n.original_width, A9n.original_height]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [A9n.thumbnail_size, A9n.thumbnail_size]
  end
end
