class MakeUserHasMoreThanOneBusiness < ActiveRecord::Migration
  def change
    remove_index :businesses, :user_id 
  end
end
