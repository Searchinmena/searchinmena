require 'rails_helper'

describe ProductCategoriesController do
  describe "#index" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { get :index }
    end

    context "user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      let(:repository) { double }
      let(:category) { double }
      let(:parent_id) { '4' }
      let(:locale) { 'en' }

      it "is successful" do
        expect(controller).to receive(:product_category_repository)
          .and_return(repository)
        expect(repository).to receive(:for_parent_id).with(parent_id, locale)
          .and_return([category])
        expect(CategoryPresenter).to receive(:new).with(category)
          .and_return({})

        get :index, parent_id: parent_id, locale: locale

        expect(response).to be_successful
      end
    end
  end
end

