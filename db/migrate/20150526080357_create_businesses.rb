class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name, null: false
      t.string :country, null: false
      t.string :phone, null: false
      t.integer :business_type, null: false

      t.timestamps
    end
  end
end

