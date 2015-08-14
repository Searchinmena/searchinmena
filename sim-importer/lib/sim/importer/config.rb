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

      def current_db
        db["current_db"]
      end
    end
  end
end
