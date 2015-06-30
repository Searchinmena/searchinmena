class AddIndexesForTypeFields < ActiveRecord::Migration
  def change
    add_index :categories, :type
    add_index :translatable, :type
  end
end
