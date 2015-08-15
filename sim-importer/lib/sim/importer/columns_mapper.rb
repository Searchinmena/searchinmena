module Sim
  module Importer
    class ColumnsMapper
      attr_accessor :mapping

      def initialize(mapping)
        self.mapping = mapping
      end

      def run(old_table, row)
        mapping.old_columns(old_table).map do |column_name|
          row[column_name]
        end
      end
    end
  end
end
