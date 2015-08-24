module Sim
  module Importer
    class BusinessItemSqlBuilder < StandardSqlBuilder
      def additional_columns
        ["created_at", "updated_at"]
      end

      def additional_values
        ['NOW()', 'NOW()']
      end
    end
  end
end
