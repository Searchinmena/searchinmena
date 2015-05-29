require "rails_helper"

describe FacebookUserRepository do
  fake(:user_repository)

  let(:facebook_attributes) {
    {
      "info" => {
        "nickname" => 'jbloggs',
        "email" => 'joe@bloggs.com',
        "name" => 'Joe Bloggs',
        "first_name" => 'Joe',
        "last_name" => 'Bloggs'
      }
    }
  }

  subject { FacebookUserRepository.new(user_repository) }

  it "initiates new user" do
    expect(user_repository).to receive(:new)
    subject.new(facebook_attributes)
  end
end
