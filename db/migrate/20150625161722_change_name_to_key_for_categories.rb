class ChangeNameToKeyForCategories < ActiveRecord::Migration
  def change
    rename_column :categories, :name, :key
  end
end
