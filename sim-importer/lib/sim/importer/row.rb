module Sim
  module Importer
    Row = Struct.new(:row_data) do
      def [](key)
        row_data[key]
      end
    end
  end
end
