require 'csv'

desc 'Update product/service categories'
task update_categories: :environment do
  ID_MAPPING_FILE_PATH = "./sim-importer/config/ids_mapping.yml"
  ids_map = YAML.load(File.read(ID_MAPPING_FILE_PATH))

  Factory = Struct.new(:klass, :category_repository)

  factories = {
    products: Factory.new(Product, ProductCategoryRepository.new),
    services: Factory.new(Service, ServiceCategoryRepository.new)
  }

  factories.each do |resource, factory|
    CSV.foreach(path2(resource)) do |old_id, category_name|
      begin
        p "Updating #{resource} #{old_id}..."

        new_id = ids_map[resource.to_s][old_id.to_i]
        next unless new_id

        business_item = factory.klass.find_by_id(new_id)
        next unless business_item

        category = factory.category_repository
          .find_by_translation(category_name, "en")

        business_item.category = category
        business_item.save
      rescue => e
        p e
      end
    end
  end
end

def path2(resource)
  Rails.root.join("sim-importer", "config", "#{resource}_categories.csv")
end
