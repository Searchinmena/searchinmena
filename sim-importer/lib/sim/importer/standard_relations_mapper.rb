module Sim
  module Importer
    class StandardRelationsMapper
      attr_accessor :ids_mapper

      def initialize(mappers)
        self.ids_mapper = mappers[:ids_mapper]
      end

      def run(args)
        table_name = args.fetch(:table_name)
        old_id = args.fetch(:old_id)
        ids_mapper.new_id(table_name, old_id)
      end
    end
  end
end
