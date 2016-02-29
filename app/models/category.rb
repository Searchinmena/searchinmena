class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category', foreign_key: :parent_id
  has_many :translations, class_name: 'CategoryTranslation'
  accepts_nested_attributes_for :translations
  def parent?
    parent.nil?
  end

  def english_title
    translations.where(locale: 'en').pluck(:value).join(' ')
  end
end
