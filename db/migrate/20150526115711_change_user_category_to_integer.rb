class ChangeUserCategoryToInteger < ActiveRecord::Migration
  def change
    change_column :users, :category, 'integer USING CAST(category AS integer)'
  end
end
