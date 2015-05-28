class CreateBusinessesTags < ActiveRecord::Migration
  def change
    create_table :businesses_tags do |t|
      t.integer :business_id
      t.integer :tag_id

      t.timestamps
    end

    add_index :businesses_tags, [:business_id, :tag_id], unique: true
  end
end
