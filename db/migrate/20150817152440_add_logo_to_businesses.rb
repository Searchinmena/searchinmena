class AddLogoToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :logo, :string
  end
end
