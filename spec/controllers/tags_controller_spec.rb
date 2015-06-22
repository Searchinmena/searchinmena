require 'rails_helper'

describe TagsController do
  describe "#index" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { get :index }
    end

    context "user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      context "without query param" do
        it "is success" do
          get :index
          expect(response).to be_successful
        end
      end

      context "with query param" do
        fake(:tag_repository)
        let(:query) { "Ania" }
        let(:tag) { double(name: 'Ania') }

        it "is success" do
          expect(controller).to receive(:tag_repository)
            .and_return(tag_repository)
          expect(tag_repository).to receive(:find_with_query)
            .with(query)
            .and_return([tag])

          get :index, query: query

          expect(response).to be_successful
        end
      end
    end
  end
end
