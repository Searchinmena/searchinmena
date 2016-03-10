class SetWeightToBusiness < ActiveRecord::Migration
  def change
  	change_column :businesses, :weight, :integer, default: 0
  end
end
