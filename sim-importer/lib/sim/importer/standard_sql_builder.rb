module Sim
  module Importer
    class StandardSqlBuilder
      attr_accessor :mapping, :columns_mapper, :relations_mapper

      def initialize(mapping, columns_mapper, relations_mapper)
        self.mapping = mapping
        self.columns_mapper = columns_mapper
        self.relations_mapper = relations_mapper
      end

      def run(old_table, row)
        new_table = mapping.new_table(old_table)

        "INSERT INTO " \
          "#{new_table} (#{insert_list(old_table)}) " \
          "values #{values(old_table, row)}"
      end

      def insert_list(old_table)
        new_columns = mapping.new_columns(old_table)
        new_relations = mapping.new_relations(old_table)

        (new_columns + additional_columns + new_relations).join(", ")
      end

      def values(old_table, row)
        mapped_columns = columns_mapper.run(old_table, row)
        mapped_relations = relations_mapper.run(old_table, row)
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
