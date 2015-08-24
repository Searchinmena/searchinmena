require 'csv'

desc 'Upload production photos'
task upload_production_photos: :environment do
  ID_MAPPING_FILE_PATH = "./sim-importer/config/ids_mapping.yml"
  ids_map = YAML.load(File.read(ID_MAPPING_FILE_PATH))

  factories = {
    products: ProductPhoto,
    services: ServicePhoto
  }

  factories.each do |resource, photo_factory|
    CSV.foreach(path(resource)) do |old_product_id, photo_url|
      begin
        p "Uploading #{photo_url}..."

        product_id = ids_map[resource.to_s][old_product_id.to_i]
        next unless product_id

        string_io = open(photo_url).read
        tmp_photo = Tempfile.new(['tmp', '.jpg'])
        tmp_photo.binmode
        tmp_photo.write(string_io)
        photo = File.open(tmp_photo.path)

        pp = photo_factory.create(product_id: product_id, photo: photo)
        pp.photo.recreate_versions!
      rescue => e
        p e
      end
    end
  end
end

def path(resource)
  Rails.root.join("sim-importer", "config", "#{resource}_photos.csv")
end
