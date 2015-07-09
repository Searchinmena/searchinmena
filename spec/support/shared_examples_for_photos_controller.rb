shared_examples "PhotosController" do
  describe "#create" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { post :create }
    end

    context "user is logged in" do
      let(:creator) { double(:creator) }
      let(:creator_response) { double(successful?: successful) }
      let(:user) { create(:user) }
      let(:business_item_id) { "4" }
      let(:business_item) { double(:business_item) }
      let(:file) { "file" }

      before do
        sign_in(user)

        expect(controller).to receive(:photo_creator)
          .and_return(creator)
        expect(creator).to receive(:perform).with(business_item, file)
          .and_return(creator_response)
        expect(controller).to receive(:repository)
          .and_return(repository)
        expect(repository).to receive(:find_for_user)
          .with(user, business_item_id)
          .and_return(business_item)
      end

      let(:repository) { double }

      context "creation successful" do
        let(:successful) { true }

        before do
          post :create, business_item_id: business_item_id, file: file
        end

        it { expect(response).to be_successful }
      end

      context "creation failed" do
        let(:successful) { false }

        before do
          expect(PhotosErrorPresenter).to receive(:new)
            .with(file, creator_response)

          post :create, business_item_id: business_item_id, file: file
        end

        it { expect(response).not_to be_successful }
      end
    end
  end
end
