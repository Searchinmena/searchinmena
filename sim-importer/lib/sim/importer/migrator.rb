module Sim
  module Importer
    class Migrator
      attr_accessor :config, :mapping

      def initialize(config, mapping)
        self.config = config
        self.mapping = mapping
      end

      def run(old_table, values)
        new_table = mapping.new_table(old_table)
        new_columns = mapping.new_columns(old_table)
        command = "INSERT INTO" \
          "#{new_table} (#{new_columns.join(", ")})" \
          "values #{values};"

        puts command
      end
    end
  end
end
