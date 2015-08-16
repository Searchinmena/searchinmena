module Sim
  module Importer
    class CountriesRelationsMapper
      attr_accessor :countries_mapper

      def initialize(mappers)
        self.countries_mapper = mappers[:countries_mapper]
      end

      def run(args)
        countries_mapper.new_id(args.fetch(:old_id))
      end
    end
  end
end
