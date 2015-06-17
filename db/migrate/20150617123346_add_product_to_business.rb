class AddProductToBusiness < ActiveRecord::Migration
  def change
    add_column :products, :business_id, :integer, null: false
  end
end
