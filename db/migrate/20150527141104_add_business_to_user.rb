class AddBusinessToUser < ActiveRecord::Migration
  def change
    add_column :businesses, :user_id, :integer, null: false
    add_index :businesses, :user_id, unique: true
  end
end
