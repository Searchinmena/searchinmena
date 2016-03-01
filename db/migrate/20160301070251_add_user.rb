class AddUser < ActiveRecord::Migration
  def change
    AdminUser.create!(email: 'searchinmena@live.com', password: 'admin@123')
  end
end
