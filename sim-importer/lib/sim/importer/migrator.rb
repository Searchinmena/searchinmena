module Sim
  module Importer
    class Migrator
      attr_accessor :new_connection, :sql_builder_factory, :ids_mapper

      def initialize(new_connection, sql_builder_factory, ids_mapper)
        self.new_connection = new_connection
        self.sql_builder_factory = sql_builder_factory
        self.ids_mapper = ids_mapper
      end

      def run(old_table, old_data)
        old_data.each do |row|
          sql_builder = sql_builder_factory.build(old_table)
          command = sql_builder.run(old_table, row)
          puts command
          #new_id = new_connection.insert(command)
          new_id = row["id"] # TODO: REMOVE IT SOME DAY!1
          ids_mapper.set(old_table, row["id"], new_id)
        end
      end
    end
  end
end
