shared_examples "TranslatableController" do
  describe "#index" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { get :index }
    end

    context "user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      let(:repository) { double }
      let(:translatable) { double }

      it "is successful" do
        expect(controller).to receive(:repository).and_return(repository)
        expect(repository).to receive(:all_with_translations).with("en")
          .and_return([translatable])
        expect(TranslatablePresenter).to receive(:new).with(translatable)
          .and_return({})

        get :index, locale: 'en'

        expect(response).to be_successful
      end
    end
  end
end
