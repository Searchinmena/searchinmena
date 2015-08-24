module Sim
  module Importer
    class Cleaner
      attr_accessor :new_connection
      SELLER_CATEGORY = 0

      def initialize(new_connection)
        self.new_connection = new_connection
      end

      def run
        command = "SELECT user_id FROM businesses"
        data = new_connection.select_all(command)
        ids = data.map { |row_data| row_data["user_id"] }
        clean_command = "UPDATE users SET category=#{SELLER_CATEGORY} " \
          "where id in (#{ids.join(", ")})"
        new_connection.update(clean_command)
      end
    end
  end
end
