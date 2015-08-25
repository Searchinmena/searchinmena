require 'csv'

desc 'Upload production photos'
task upload_production_photos: :environment do
  ID_MAPPING_FILE_PATH = "./sim-importer/config/ids_mapping.yml"
  ids_map = YAML.load(File.read(ID_MAPPING_FILE_PATH))

  Factory = Struct.new(:klass, :relation_name)

  factories = {
    products: Factory.new(ProductPhoto, :product_id),
    services: Factory.new(ServicePhoto, :service_id)
  }

  factories.each do |resource, factory|
    CSV.foreach(path(resource)) do |old_id, photo_url|
      begin
        p "Uploading #{photo_url}..."

        business_item_id = ids_map[resource.to_s][old_id.to_i]
        next unless business_item_id

        string_io = open(photo_url).read
        tmp_photo = Tempfile.new(['tmp', '.jpg'])
        tmp_photo.binmode
        tmp_photo.write(string_io)
        photo = File.open(tmp_photo.path)

        pp = factory.klass.create(factory.relation_name => business_item_id,
                                  :photo => photo)
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
