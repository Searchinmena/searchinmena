module Sim
  module Importer
    class OldDataRetriever
      attr_accessor :old_connection

      def initialize(old_connection)
        self.old_connection = old_connection
      end

      def run(old_table)
        command = "SELECT * FROM #{old_table} LIMIT 3"
        old_connection.select_all(command).map do |row_data|
          Row.new(row_data)
        end
      end
    end
  end
end
