class RemoveBusinessTypeFromBusiness < ActiveRecord::Migration
  def change
    remove_column :businesses, :business_type, :integer
  end
end
