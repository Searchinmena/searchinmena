class AddFeatureToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :feature, :boolean, default: false
    add_column :businesses, :weight, :integer
  end
end
