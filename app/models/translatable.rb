class Translatable < ActiveRecord::Base
  self.table_name = :translatable
  has_many :translations

  def english_title
    translations.where(locale: 'en').pluck(:value).join(' ')
  end
end
