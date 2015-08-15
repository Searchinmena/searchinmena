module Sim
  module Importer
    class IdsMapper
      def initialize
        @repository = {}
      end

      def set(table, old_id, new_id)
        @repository[table] ||= {}

        @repository[table][old_id] = new_id
        p @repository
      end

      def new_id(table, old_id)
        @repository[table][old_id]
      end
    end
  end
end
