require "rails_helper"

describe FacebookUserPrefillParams do
  let(:facebook_attributes) do
    {
      "provider" => "facebook",
      "uid" => "1234567",
      "info" => {
        "nickname" => "jbloggs",
        "email" => "joe@bloggs.com",
        "name" => "Joe Bloggs",
        "first_name" => "Joe",
        "last_name" => "Bloggs"
      }
    }
  end

  subject { FacebookUserPrefillParams.new(facebook_attributes).attributes }

  it "includes facebook attributes" do
    expect(subject).to include(
      first_name: "Joe",
      last_name: "Bloggs",
      email: "joe@bloggs.com",
      provider: "facebook",
      uid: "1234567"
    )
  end
end
