class CreateBusinessesBusinessTypes < ActiveRecord::Migration
  def change
    create_table :businesses_business_types do |t|
      t.integer :business_id
      t.integer :business_type_id

      t.timestamps
    end

    add_index :businesses_business_types, [:business_id, :business_type_id],
              unique: true, name: 'index_businesses_business_types'
  end
end
