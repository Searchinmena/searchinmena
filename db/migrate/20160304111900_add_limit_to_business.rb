class AddLimitToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :limit, :integer, default: 5
  end
end
