class UpdateDefaultItemLimit < ActiveRecord::Migration
  def change
    change_column :businesses, :limit, :integer, default: 25
    Business.update_all(limit: 25)
  end
end
