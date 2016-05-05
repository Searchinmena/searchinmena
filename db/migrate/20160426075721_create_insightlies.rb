class CreateInsightlies < ActiveRecord::Migration
  def change
    create_table :insightlies do |t|
      t.string :name
      t.integer :user_id
      t.string :insightly_type
      t.integer :type_id

      t.timestamps null: false
    end
  end
end
