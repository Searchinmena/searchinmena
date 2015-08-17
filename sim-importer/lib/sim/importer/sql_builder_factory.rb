module Sim
  module Importer
    class SqlBuilderFactory
      REPOSITORY = {
        users: UserSqlBuilder
      }

      attr_accessor :mapping, :columns_mapper, :relations_mapper

      def initialize(mapping, columns_mapper, relations_mapper)
        self.mapping = mapping
        self.columns_mapper = columns_mapper
        self.relations_mapper = relations_mapper
      end

      def build(new_table)
        klass = REPOSITORY[new_table.to_sym] || StandardSqlBuilder
        klass.new(mapping, columns_mapper, relations_mapper)
      end
    end
  end
end
