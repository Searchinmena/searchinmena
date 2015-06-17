class CreateTranslatable < ActiveRecord::Migration
  def change
    create_table :translatable do |t|
      t.string :key
      t.string :type

      t.timestamps
    end
  end
end
