module Sim
  module Importer
    class NewConnection < Connection
      establish_connection Config.new.new_db
    end
  end
end
