class AddMetaInformationToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :meta_title, :string
    add_column :categories, :meta_keywords, :string
    add_column :categories, :meta_description, :string
  end
end
