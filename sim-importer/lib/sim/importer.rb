require "./lib/sim/importer/version"
require "./lib/sim/importer/config"
require "./lib/sim/importer/mapping"
require "./lib/sim/importer/connection"
require "./lib/sim/importer/mapper"
require "./lib/sim/importer/old_data_retriever"
require "./lib/sim/importer/values_mapper"
require "./lib/sim/importer/migrator"
require "yaml"

module Sim
  module Importer
    def self.run
      config = Config.new
      mapping = Mapping.new
      old_data_retriever = OldDataRetriever.new(config, mapping)
      values_mapper = ValuesMapper.new
      migrator = Migrator.new(config, mapping)

      mapper = Mapper.new(mapping, old_data_retriever, values_mapper, migrator)
      mapper.run
    end
  end
end
