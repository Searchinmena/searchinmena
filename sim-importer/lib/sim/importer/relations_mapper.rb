module Sim
  module Importer
    class RelationsMapper
      attr_accessor :mapping, :ids_mapper

      def initialize(mapping, ids_mapper)
        self.mapping = mapping
        self.ids_mapper = ids_mapper
      end

      def run(old_table, row)
        mapping.old_relations(old_table).map do |relation_name|
          table_name = mapping.old_relation_table_name(
            old_table, relation_name)
          old_id = row[relation_name]
          ids_mapper.new_id(table_name, old_id)
        end
      end
    end
  end
end
