class TestUsersSeeder
  TEST_USERS = {
    seller: "seller@example.org",
    buyer: "buyer@example.org",
    both: "both@example.org"
  }
  TEST_PASSWORD = "testtest"

  def seed
    return if Rails.env.production?

    require 'factory_girl'
    require './spec/support/factories'

    TEST_USERS.each do |type, email|
      next if User.where(email: email).count > 0

      FactoryGirl.create(
        type,
        email: email,
        password: TEST_PASSWORD,
        password_confirmation: TEST_PASSWORD
      )
    end
  end
end
