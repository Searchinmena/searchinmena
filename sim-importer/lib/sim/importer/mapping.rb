module Sim
  module Importer
    class Mapping
      MAPPING_PATH = "./config/mapping.yml"

      attr_accessor :mapping

      def initialize
        self.mapping = YAML.load(File.read(MAPPING_PATH))
      end

      def each_new_table(&block)
        mapping.each_key(&block)
      end

      def old_tables(new_table)
        mapping[new_table].keys
      end

      def group_by(new_table, old_table)
        mapping[new_table][old_table]["group_by"] || "id"
      end

      def old_columns(new_table)
        mapping[new_table].values.map do |v|
          v["columns"]
        end.compact.map(&:keys).flatten
      end

      def new_columns(new_table)
        mapping[new_table].values.map do |v|
          v["columns"]
        end.compact.map(&:values).flatten
      end

      def old_relations(new_table)
        mapping[new_table].values.map do |v|
          v["relations"]
        end.compact.reduce(Hash.new, :merge)
      end

      def new_relations(new_table)
        mapping[new_table].values.map do |v|
          v["relations"]
        end.compact.map(&:values).flatten.map { |v| v["new_name"] }
      end
    end
  end
end
