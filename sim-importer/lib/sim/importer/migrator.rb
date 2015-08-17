module Sim
  module Importer
    class Migrator
      attr_accessor :new_connection, :sql_builder_factory, :ids_mapper

      def initialize(new_connection, sql_builder_factory, ids_mapper)
        self.new_connection = new_connection
        self.sql_builder_factory = sql_builder_factory
        self.ids_mapper = ids_mapper
      end

      def run(old_data, new_table)
        old_data.each do |row|
          sql_builder = sql_builder_factory.build(new_table)
          command = sql_builder.run(new_table, row)
          puts command
          new_id = new_connection.insert(command)
          ids_mapper.set(new_table, row["id"], new_id)
        end
      end
    end
  end
end
