class TestUsersSeeder
  def seed
    return if Rails.env.production?

    require 'factory_girl'
    require './spec/support/factories'

    unless User.where(email: TEST_EMAIL).count > 0
      FactoryGirl.create(:user, email: TEST_EMAIL, password: TEST_PASSWORD)
    end
  end
end
