module Sim
  module Importer
    class ValuesMapper
      def run(data)
        values = data.map do |item_row|
          mapped_columns = item_row.map { |column| "'#{column}'" }
          "(#{mapped_columns.join(", ")})"
        end
        values.join(",\n")
      end
    end
  end
end
