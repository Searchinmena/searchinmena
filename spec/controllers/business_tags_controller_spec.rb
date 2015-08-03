require "rails_helper"

describe BusinessTagsController do
  describe "#index" do
    let(:business) { create(:business, tags: [create(:tag)]) }
    let(:tag_repository) { double }
    let(:translatable) { double }
    let(:locale) { "en" }

    it "is successful" do
      expect(controller).to receive(:tag_repository).and_return(tag_repository)
      expect(tag_repository).to receive(:for_business_with_translations)
        .with(business.id.to_s, locale)
        .and_return([translatable])
      expect(TranslatablePresenter).to receive(:new).with(translatable)
        .and_return({})

      get :index, locale: locale, business_id: business.id
      expect(response).to be_successful
    end
  end
end
