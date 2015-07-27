class ChangeIntroductionType < ActiveRecord::Migration
  def change
    change_column :businesses, :introduction, :text
  end
end
