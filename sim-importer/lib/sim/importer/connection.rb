module Sim
  module Importer
    class Connection < ActiveRecord::Base
      def self.select_all(command)
        connection.select_all(command)
      end

      def self.insert(command)
        connection.insert(command)
      end

      def self.update(command)
        connection.update(command)
      end
    end
  end
end
