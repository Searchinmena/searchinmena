module Sim
  module Importer
    class Mapping
      MAPPING_PATH = "./config/mapping.yml"

      attr_accessor :mapping

      def initialize
        self.mapping = YAML.load(File.read(MAPPING_PATH))
      end

      def each_old_table(&block)
        mapping.each_key(&block)
      end

      def old_columns(old_table)
        mapping[old_table]["columns"].keys
      end

      def new_columns(old_table)
        mapping[old_table]["columns"].values
      end

      def new_table(old_table)
        mapping[old_table]["new_table"]
      end
    end
  end
end
