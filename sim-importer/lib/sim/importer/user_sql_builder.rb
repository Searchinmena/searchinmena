require 'bcrypt'

module Sim
  module Importer
    class UserSqlBuilder < StandardSqlBuilder
      PASSWORD_LENGTH = 8
      PASSWORD_RANGE = [*'0'..'9', *'a'..'z']

      def additional_columns
        ["encrypted_password"]
      end

      def additional_values
        [generate_encrypted_password]
      end

      private

      def generate_encrypted_password
        password = PASSWORD_LENGTH.times.map do
          PASSWORD_RANGE.sample
        end.join
        BCrypt::Password.create(password)
      end
    end
  end
end
