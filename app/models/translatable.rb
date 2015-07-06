class Translatable < ActiveRecord::Base
  self.table_name = :translatable

  has_many :translations
end
