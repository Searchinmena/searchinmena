module Sim
  module Importer
    class ColumnsMapper
      attr_accessor :mapping

      def initialize(mapping)
        self.mapping = mapping
      end

      def run(new_table, row)
        mapping.old_columns(new_table).map do |column_name|
          map_column(column_name, row)
        end
      end

      def map_column(column_name, row)
        value = row[column_name]
        if value.nil? || value == ''
          'NULL'
        elsif value.is_a?(String)
          if  value.match(/^[0-9]+$/)
            value
          else
            "'#{value.gsub("'", "''")}'"
          end
        else
          value
        end
      end
    end
  end
end
