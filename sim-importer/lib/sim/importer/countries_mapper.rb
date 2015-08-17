module Sim
  module Importer
    class CountriesMapper
      def initialize(old_connection, new_connection)
        old_countries = old_countries(old_connection)
        new_countries = new_countries(new_connection)
        @repository = {}
        new_countries.each do |country|
          old_id = old_countries[country["value"]]
          @repository[old_id] = country["id"]
        end
      end

      def new_id(old_id)
        @repository[old_id]
      end

      private

      def old_countries(old_connection)
        command = "SELECT id, name FROM countries"
        old_countries = old_connection.select_all(command)

        old_countries = old_countries.map do |country|
          { country["name"] => country["id"] }
        end
        old_countries.reduce(Hash.new, :merge)
      end

      def new_countries(new_connection)
        command = "SELECT countries.id, type, value, locale, translatable_id " \
          "FROM translatable AS countries " \
          "JOIN translations ON countries.id = translations.translatable_id " \
          "WHERE countries.type = 'Country' AND locale = 'en'"
        new_countries = new_connection.select_all(command)
      end
    end
  end
end
