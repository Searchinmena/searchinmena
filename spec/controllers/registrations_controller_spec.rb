require 'rails_helper'

describe RegistrationsController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#new" do
    it "is successful" do
      get :new
      expect(response).to be_successful
    end
  end
end
