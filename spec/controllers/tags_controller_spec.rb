require 'rails_helper'

describe TagsController do
  describe "#index" do
    context "without query param" do
      it "is success" do
        get :index
        expect(response).to be_successful
      end
    end

    context "with query param" do
      fake(:tag_repository)
      let(:query) { "Ania" }
      let(:locale) { "en" }
      let(:tag) { create(:tag) }

      it "is success" do
        expect(controller).to receive(:tag_repository)
          .and_return(tag_repository)
        expect(controller).to receive(:locale).and_return(locale)
        expect(tag_repository).to receive(:find_with_query)
          .with(query, locale)
          .and_return([tag])

        get :index, query: query

        expect(response).to be_successful
      end
    end
  end
end
