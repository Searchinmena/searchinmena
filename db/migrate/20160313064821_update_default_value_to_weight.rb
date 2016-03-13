class UpdateDefaultValueToWeight < ActiveRecord::Migration
  def change
    change_column :businesses, :weight, :integer, default: 0
    Business.update_all(weight: 0)
  end
end
