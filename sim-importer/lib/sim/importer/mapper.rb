module Sim
  module Importer
    class Mapper
      attr_accessor :mapping, :old_data_retriever, :new_connection,
        :migrator

      def initialize(mapping, old_data_retriever, new_connection, migrator)
        self.mapping = mapping
        self.old_data_retriever = old_data_retriever
        self.new_connection = new_connection
        self.migrator = migrator
      end

      def run
        new_connection.transaction do
          mapping.each_new_table do |new_table|
            puts "Moving #{new_table}\n\n"

            old_data = old_data_retriever.run(new_table)
            migrator.run(old_data, new_table)

            puts "\nMoved #{new_table}\n\n\n"
          end
        end
      end
    end
  end
end
