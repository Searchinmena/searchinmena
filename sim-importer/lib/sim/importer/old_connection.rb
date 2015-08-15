module Sim
  module Importer
    class OldConnection < Connection
      establish_connection Config.new.old_db
    end
  end
end
