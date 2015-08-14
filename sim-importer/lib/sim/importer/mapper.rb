module Sim
  module Importer
    class Mapper
      attr_accessor :mapping, :old_data_retriever, :values_mapper, :migrator

      def initialize(mapping, old_data_retriever, values_mapper, migrator)
        self.mapping = mapping
        self.old_data_retriever = old_data_retriever
        self.values_mapper = values_mapper
        self.migrator = migrator
      end

      def run
        mapping.each_old_table do |old_table|
          puts "Moving #{old_table}\n\n"

          old_data = old_data_retriever.run(old_table)
          values = values_mapper.run(old_data)

          migrator.run(old_table, values)
          puts "\nMoved #{old_table}\n\n\n"
        end
      end
    end
  end
end
