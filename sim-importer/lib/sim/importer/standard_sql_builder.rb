module Sim
  module Importer
    class StandardSqlBuilder
      attr_accessor :mapping, :columns_mapper, :relations_mapper

      def initialize(mapping, columns_mapper, relations_mapper)
        self.mapping = mapping
        self.columns_mapper = columns_mapper
        self.relations_mapper = relations_mapper
      end

      def run(new_table, row)
        "INSERT INTO " \
          "#{new_table} (#{insert_list(new_table)}) " \
          "values #{values(new_table, row)}"
      end

      def insert_list(new_table)
        new_columns = mapping.new_columns(new_table)
        new_relations = mapping.new_relations(new_table)

        (new_columns + additional_columns + new_relations).join(", ")
      end

      def values(new_table, row)
        mapped_columns = columns_mapper.run(new_table, row)
        mapped_relations = relations_mapper.run(new_table, row)
        mapped_all = (mapped_columns + additional_values + mapped_relations)
        "(#{quoted(mapped_all).join(", ")})"
      end

      def quoted(list)
        list.map { |v| "'#{v}'" }
      end

      def additional_columns
        []
      end

      def additional_values
        []
      end
    end
  end
end
