shared_examples "business item creator" do
  describe "#perform" do
    let(:creator) { described_class.new(business_item_params, user) }
    let(:validator) do
      double(:validator, valid?: valid, errors?: !valid)
    end

    let(:business_item_params) do
      {
        business_item: build_params(business_item),
        attributes: []
      }
    end
    let(:user) { create(:seller) }

    before do
      expect(validator_factory).to receive(:new)
        .and_return(validator)
    end

    subject { creator.perform }

    context "business item validation passed" do
      let(:valid) { true }

      before do
        response = double(successful?: true,
                          object: double(:business_item))
        creator = double(perform: response)
        expect(attributes_creator_class).to receive(:new)
          .and_return(creator)
        expect(payment_terms_creator_class).to receive(:new)
          .and_return(creator)
      end

      it { is_expected.to be_successful }

      it "saves business item" do
        subject
        expect(business_items).not_to be_empty
      end
    end

    context "business item validation failed" do
      let(:valid) { false }

      before do
        expect(validator).to receive(:copy_errors)
      end

      it { is_expected.not_to be_successful }

      it "doesn't save business item" do
        subject
        expect(business_items).to be_empty
      end
    end
  end
end

