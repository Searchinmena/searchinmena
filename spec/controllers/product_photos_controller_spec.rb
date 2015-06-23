require 'rails_helper'

describe ProductPhotosController do
  describe "#create" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { post :create }
    end

    context "user is logged in" do
      let(:creator) { double(:creator) }
      let(:creator_response) { double(successful?: successful) }
      let(:user) { create(:user) }
      let(:product_id) { "4" }
      let(:product) { double(:product) }
      let(:file) { "file" }

      before do
        sign_in(user)

        expect(controller).to receive(:product_photo_creator)
          .and_return(creator)
        expect(creator).to receive(:perform).with(product, file)
          .and_return(creator_response)
        expect(controller).to receive(:product_repository)
          .and_return(product_repository)
        expect(product_repository).to receive(:find_for_user)
          .with(user, product_id)
          .and_return(product)
      end

      fake(:product_repository)

      context "creation successful" do
        let(:successful) { true }

        before do
          post :create, product_id: product_id, file: file
        end

        it { expect(response).to be_successful }
      end

      context "creation failed" do
        let(:successful) { false }

        before do
          expect(ProductPhotosErrorPresenter).to receive(:new)
            .with(file, creator_response)

          post :create, product_id: product_id, file: file
        end

        it { expect(response).not_to be_successful }
      end
    end
  end
end
