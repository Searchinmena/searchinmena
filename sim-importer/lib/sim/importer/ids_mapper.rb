module Sim
  module Importer
    class IdsMapper
      ID_MAPPING_FILE_PATH = "./config/ids_mapping.yml"

      def initialize
        @repository = {}
      end

      def set(table, old_id, new_id)
        @repository[table] ||= {}

        @repository[table][old_id] = new_id
      end

      def new_id(table, old_id)
        @repository[table][old_id.to_i]
      end

      def save
        File.open(ID_MAPPING_FILE_PATH, "w") do |f|
          f.puts(@repository.to_yaml)
        end
      end
    end
  end
end
