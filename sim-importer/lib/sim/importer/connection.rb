require "active_record"

module Sim
  module Importer
    class Connection
      def self.establish(config, &block)
        ActiveRecord::Base.establish_connection(config)
          .with_connection(&block)
      end
    end
  end
end
