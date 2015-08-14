module Sim
  module Importer
    class OldDataRetriever
      attr_accessor :config, :mapping

      def initialize(config, mapping)
        self.config = config
        self.mapping = mapping
      end

      def run(old_table)
        old_columns = mapping.old_columns(old_table).join(", ")
        Connection.establish(config.old_db) do |old_db|
          old_db.execute("SELECT #{old_columns} FROM #{old_table} LIMIT 3").to_a
        end
      end
    end
  end
end
