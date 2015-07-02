class CreateCategoryTranslations < ActiveRecord::Migration
  def change
    create_table :category_translations do |t|
      t.string :locale, null: false
      t.text   :value, null: false
      t.integer :category_id, null: false

      t.timestamps null: false
    end
  end
end
