class SetDefaultUserCategory < ActiveRecord::Migration
  def change
    change_column :users, :category, :integer,
      default: User.categories[:seller]
  end
end
