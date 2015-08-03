require "rails_helper"

describe BusinessesController do
  describe "#show" do
    let(:business) { create(:business) }

    it "is not found" do
      get :show, id: "not exisint id"
      expect(response).to be_not_found
    end

    it "is successful" do
      get :show, id: business.id
      expect(response).to be_successful
    end
  end
end
