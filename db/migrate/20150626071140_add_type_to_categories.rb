class AddTypeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :type, :string, null: false
  end
end
