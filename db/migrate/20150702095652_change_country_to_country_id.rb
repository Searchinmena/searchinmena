class ChangeCountryToCountryId < ActiveRecord::Migration
  def change
    remove_column :businesses, :country, :string
    add_column :businesses, :country_id, :integer, null: false
  end
end
