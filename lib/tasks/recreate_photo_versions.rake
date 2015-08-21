desc 'Recreate photo versions'
task recreate_photo_versions: :environment do
  photos = ProductPhoto.all + ServicePhoto.all
  photos = photos[0..1]
  photos.each do |o|
    begin
      o.process_photo_upload = true
      o.photo.cache_stored_file!
      o.photo.retrieve_from_cache!(o.photo.cache_name)
      o.photo.recreate_versions!(:bigger_thumb)
      o.save
    rescue => e
      puts "ERROR: #{o.class}: #{o.id} -> #{e}"
    end
  end
end
