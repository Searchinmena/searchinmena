class AddLogoTmpToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :logo_tmp, :string
  end
end
