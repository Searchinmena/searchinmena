module Sim
  module Importer
    class CountriesMapper
      def initialize(old_connection, new_connection)
        @repository = {}
      end

      def new_id(old_id)
        @repository[old_id]
      end
    end
  end
end
