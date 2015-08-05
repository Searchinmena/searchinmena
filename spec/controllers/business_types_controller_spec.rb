require "rails_helper"

describe BusinessTypesController do
  describe "#index" do
    let(:repository) { double }
    let(:translatable) { double }
    let(:locale) { "en" }

    context "without business_id param" do
      it "is successful" do
        expect(controller).to receive(:repository).and_return(repository)
        expect(repository).to receive(:all_with_translations).with(locale)
          .and_return([translatable])
        expect(TranslatablePresenter).to receive(:new).with(translatable)
          .and_return({})

        get :index, locale: locale

        expect(response).to be_successful
      end
    end

    context "with business_id" do
      let(:business_id) { "44" }

      it "is successful" do
        expect(controller).to receive(:repository).and_return(repository)
        expect(repository).to receive(:for_business_with_translations)
          .with(business_id, locale).and_return([translatable])
        expect(TranslatablePresenter).to receive(:new).with(translatable)
          .and_return({})

        get :index, locale: locale, business_id: business_id

        expect(response).to be_successful
      end
    end
  end
end
