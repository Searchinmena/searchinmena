class DefaultCreatedAt < ActiveRecord::Migration
  def change
    change_column :products, :created_at, :datetime, null: false, default: "NOW()"
    change_column :products, :updated_at, :datetime, null: false, default: "NOW()"

    change_column :services, :created_at, :datetime, null: false, default: "NOW()"
    change_column :services, :updated_at, :datetime, null: false, default: "NOW()"
  end
end
