module Sim
  module Importer
    class Config
      CONFIG_PATH = "./config/database.yml"

      attr_accessor :db

      def initialize
        self.db = YAML.load(File.read(CONFIG_PATH))
      end

      def old_db
        db["old_db"]
      end

      def new_db
        db["new_db"]
      end
    end
  end
end
