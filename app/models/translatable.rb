class Translatable < ActiveRecord::Base
  self.table_name = :translatable

  has_many :translations, foreign_key: :key, primary_key: :key
end
