class RemoveKeyFromTranslations < ActiveRecord::Migration
  def change
    remove_column :translations, :key, :string
    remove_column :translatable, :key, :string

    add_column :translations, :translatable_id, :integer
    add_index :translations, :translatable_id
  end
end
