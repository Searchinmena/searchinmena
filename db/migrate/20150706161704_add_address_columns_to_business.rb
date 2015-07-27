class AddAddressColumnsToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :address_line_1, :string
    add_column :businesses, :address_line_2, :string
  end
end
