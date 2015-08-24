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
        # #programistaplakaljakkomitowal...
        value = row[column_name]
        if empty_time_column?(column_name, value)
          value = "NOW()"
        end
        map_value(value)
      end

      def empty_time_column?(column_name, value)
        (column_name == "created_at" || column_name == "updated_at") &&
          (value.nil? || value == "")
      end

      def map_value(value)
        if value.nil? || value == ''
          'NULL'
        elsif value.is_a?(String)
          map_string(value)
        elsif value.is_a?(Time)
          map_time(value)
        else
          value
        end
      end

      def map_string(value)
        if  value.match(/^[0-9]+$/)
          value
        else
          "'#{value.gsub("'", "''")}'"
        end
      end

      def map_time(value)
        "'#{value}'"
      end
    end
  end
end
