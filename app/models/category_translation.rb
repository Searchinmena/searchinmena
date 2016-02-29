class CategoryTranslation < ActiveRecord::Base
  LOCALE = %w(en ar)
  belongs_to :category
end
