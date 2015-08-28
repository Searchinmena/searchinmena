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

  def photo(photo_url)
    string_io = open(photo_url).read
    path = "public/uploads/tmp/tmp_photo"
    File.open(path, "wb") { |f| f.write(string_io) }
    File.open(path)
  end

  factories.each do |resource, factory|
    CSV.foreach(path(resource)) do |old_id, photo_url|
      begin
        p "Uploading #{photo_url}..."

        business_item_id = ids_map[resource.to_s][old_id.to_i]
        next unless business_item_id

        pp = factory.klass.create(factory.relation_name => business_item_id,
                                  :photo => photo(photo_url))
        pp.photo.recreate_versions!
      rescue => e
        p e
      end
    end
  end

  CSV.foreach(path(:businesses)) do |old_id, photo_url|
    begin
      p "Uploading #{photo_url}..."

      business_id = ids_map["businesses"][old_id.to_i]
      business = Business.find_by_id(business_id)
      next unless business

      business.logo = photo(photo_url)
      business.save
      business.logo.recreate_versions!
    rescue => e
      p e
    end
  end
end

def path(resource)
  Rails.root.join("sim-importer", "config", "#{resource}_photos.csv")
end
