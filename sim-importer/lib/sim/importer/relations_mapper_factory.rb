module Sim
  module Importer
    class RelationsMapperFactory
      attr_accessor :mapping, :mappers

      REPOSITORY = {
        country_id: CountriesRelationsMapper
      }

      def initialize(mappers)
        self.mappers = mappers
      end

      def build(relation_name)
        klass = REPOSITORY[relation_name.to_sym] || StandardRelationsMapper
        klass.new(mappers)
      end
    end
  end
end
