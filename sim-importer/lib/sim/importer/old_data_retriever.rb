module Sim
  module Importer
    class OldDataRetriever
      GROUP_KEY = :relation_id

      attr_accessor :mapping, :old_connection

      def initialize(mapping, old_connection)
        self.mapping = mapping
        self.old_connection = old_connection
      end

      def run(new_table)
        old_data = mapping.old_tables(new_table).map do |old_table|
          command = "SELECT * FROM #{old_table} LIMIT 3"
          data = old_connection.select_all(command)
          data.map do |row|
            key = mapping.group_by(new_table, old_table)
            row[GROUP_KEY] = row[key]
            row
          end
        end

        old_data = old_data.flatten.group_by { |v| v[GROUP_KEY] }
        old_data.values.map { |v| Row.new(v.reduce(Hash.new, :merge)) }
      end
    end
  end
end
