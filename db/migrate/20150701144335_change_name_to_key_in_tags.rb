class ChangeNameToKeyInTags < ActiveRecord::Migration
  def change
    rename_column :tags, :name, :key
  end
end
