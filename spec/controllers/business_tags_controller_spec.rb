require "rails_helper"

describe BusinessTagsController do
  describe "#index" do
    let(:business) { create(:business, tags: [create(:tag)]) }

    it "is successful" do
      get :index, locale: 'en', business_id: business.id
      expect(response).to be_successful
    end
  end
end
