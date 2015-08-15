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
        columns = mapping[old_table]["columns"]
        return [] unless columns

        columns.keys
      end

      def new_columns(old_table)
        columns = mapping[old_table]["columns"]
        return [] unless columns

        columns.values
      end

      def old_relations(old_table)
        relations = mapping[old_table]["relations"]
        return [] unless relations

        relations.keys
      end

      def new_relations(old_table)
        relations = mapping[old_table]["relations"]
        return [] unless relations

        relations.values.map { |v| v["new_name"] }
      end

      def new_table(old_table)
        mapping[old_table]["new_table"]
      end

      def old_relation_table_name(old_table, relation_name)
        mapping[old_table]["relations"][relation_name]["old_table"]
      end
    end
  end
end
