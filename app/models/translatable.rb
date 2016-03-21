class Translatable < ActiveRecord::Base
  self.table_name = :translatable
  has_many :translations

  def english_title
    if translations.present?
      translations.where(locale: 'en').pluck(:value).join(' ')
    end
  end
end
