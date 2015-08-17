module Sim
  module Importer
    class ColumnsMapper
      attr_accessor :mapping

      def initialize(mapping)
        self.mapping = mapping
      end

      def run(new_table, row)
        mapping.old_columns(new_table).map do |column_name|
          row[column_name]
        end
      end
    end
  end
end
