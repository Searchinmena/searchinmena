require "active_record"
require "yaml"
require "./lib/sim/importer/version"
require "./lib/sim/importer/config"
require "./lib/sim/importer/mapping"
require "./lib/sim/importer/connection"
require "./lib/sim/importer/old_connection"
require "./lib/sim/importer/new_connection"
require "./lib/sim/importer/mapper"
require "./lib/sim/importer/old_data_retriever"
require "./lib/sim/importer/standard_sql_builder"
require "./lib/sim/importer/user_sql_builder"
require "./lib/sim/importer/sql_builder_factory"
require "./lib/sim/importer/columns_mapper"
require "./lib/sim/importer/standard_relations_mapper"
require "./lib/sim/importer/countries_relations_mapper"
require "./lib/sim/importer/relations_mapper_factory"
require "./lib/sim/importer/relations_mapper"
require "./lib/sim/importer/migrator"
require "./lib/sim/importer/ids_mapper"
require "./lib/sim/importer/countries_mapper"
require "./lib/sim/importer/row"
require "./lib/sim/importer/cleaner"

module Sim
  module Importer
    def self.run
      old_connection = OldConnection
      new_connection = NewConnection
      mapping = Mapping.new
      old_data_retriever = OldDataRetriever.new(mapping, old_connection)
      ids_mapper = IdsMapper.new
      countries_mapper = CountriesMapper.new(old_connection, new_connection)
      columns_mapper = ColumnsMapper.new(mapping)
      mappers = {
        ids_mapper: ids_mapper,
        countries_mapper: countries_mapper
      }
      relations_mapper_factory = RelationsMapperFactory.new(mappers)
      relations_mapper = RelationsMapper.new(mapping, relations_mapper_factory)
      sql_builder_factory = SqlBuilderFactory.new(mapping, columns_mapper,
                                   relations_mapper)
      migrator = Migrator.new(new_connection, sql_builder_factory, ids_mapper)

      run_mapping(mapping, old_data_retriever, new_connection, migrator)
      run_cleaning(new_connection)
    end

    def run_mapping(mapping, old_data_retriever, new_connection, migrator)
      mapper = Mapper.new(mapping, old_data_retriever, new_connection, migrator)
      mapper.run
    end

    def run_cleaning(new_connection)
      cleaner = Cleaner.new(new_connection)
      cleaner.run
    end
  end
end
