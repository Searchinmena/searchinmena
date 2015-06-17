shared_examples "TranslatableController" do
  describe "#index" do
    let(:repository) { double }
    let(:translatable) { double }

    it "is successful" do
      expect(controller).to receive(:repository).and_return(repository)
      expect(repository).to receive(:all_with_translations).with("en")
        .and_return([translatable])
      expect(Api::TranslatablePresenter).to receive(:new).with(translatable)
        .and_return({})

      get :index, locale: 'en'

      expect(response).to be_successful
    end
  end
end
