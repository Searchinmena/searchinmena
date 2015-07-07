class CreateServiceAttributes < ActiveRecord::Migration
  def change
    create_table :service_attributes do |t|
      t.string :name, null: false
      t.string :value, null: false
      t.integer :service_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
