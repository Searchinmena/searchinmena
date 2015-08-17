module Sim
  module Importer
    class RelationsMapper
      attr_accessor :mapping, :relations_mapper_factory

      def initialize(mapping, relations_mapper_factory)
        self.mapping = mapping
        self.relations_mapper_factory = relations_mapper_factory
      end

      def run(new_table, row)
        mapping.old_relations(new_table).map do |relation_name, rel_data|
          relations_mapper = relations_mapper_factory.build(relation_name)
          table_name = rel_data["rel_table"]
          old_id = row[relation_name]
          relations_mapper.run(table_name: table_name, old_id: old_id)
        end
      end
    end
  end
end
