class AddFieldsToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :year_registered, :integer
    add_column :businesses, :no_of_employees, :integer
    add_column :businesses, :introduction, :string
  end
end
