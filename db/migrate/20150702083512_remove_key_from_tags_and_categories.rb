class RemoveKeyFromTagsAndCategories < ActiveRecord::Migration
  def change
    remove_column :tags, :key, :string
    remove_column :categories, :key, :string
  end
end
