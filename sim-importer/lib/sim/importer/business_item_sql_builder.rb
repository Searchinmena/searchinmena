module Sim
  module Importer
    class BusinessItemSqlBuilder < StandardSqlBuilder
      def additional_columns
        %w{created_at updated_at}
      end

      def additional_values
        %w{NOW() NOW()}
      end
    end
  end
end
