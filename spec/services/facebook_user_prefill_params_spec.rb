require "rails_helper"

describe FacebookUserPrefillParams do
  let(:facebook_attributes) do
    {
      "provider" => "facebook",
      "info" => {
        "nickname" => 'jbloggs',
        "email" => 'joe@bloggs.com',
        "name" => 'Joe Bloggs',
        "first_name" => 'Joe',
        "last_name" => 'Bloggs'
      }
    }
  end

  subject { FacebookUserPrefillParams.new(facebook_attributes).attributes }

  it "includes facebook attributes" do
    expect(subject).to include(:first_name, :last_name, :email, :password,
                               :password_confirmation, :provider)
  end
end
