class RevertDefaultCreatedAt < ActiveRecord::Migration
  def change
    change_column_default :products, :created_at, nil
    change_column_default :products, :updated_at, nil

    change_column_default :services, :created_at, nil
    change_column_default :services, :updated_at, nil
  end
end
