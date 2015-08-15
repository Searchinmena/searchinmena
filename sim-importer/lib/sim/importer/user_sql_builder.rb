module Sim
  module Importer
    class UserSqlBuilder < StandardSqlBuilder
      PASSWORD_LENGTH = 8
      PASSWORD_RANGE = [*'0'..'9', *'a'..'z']

      def additional_columns
        ["encrypted_password"]
      end

      def additional_values
        [generate_password]
      end

      private

      def generate_password
        PASSWORD_LENGTH.times.map do
          PASSWORD_RANGE.sample
        end.join
      end
    end
  end
end
