require 'rails_helper'

describe StoringHandler do
  describe "#perform" do
    let(:storing_handler) do
      StoringHandler.new(record, record_params, repository, validator)
    end
    let(:record) { create(:business) }
    let(:valid_params) { build_params(record) }
    let(:repository) { BusinessRepository.new }
    let(:validator) { BusinessValidator.new(record_params) }

    subject { storing_handler.perform }

    before { subject }

    context "valid params" do
      let(:record_params) { valid_params.merge(name: "new name") }

      it { is_expected.to be_successful }

      it "assigns attributes" do
        expect(record.reload.name).to eq('new name')
      end
    end

    context "invalid params" do
      let(:record_params) { valid_params.merge(name: "") }

      it { is_expected.not_to be_successful }

      it "doesn't assign attributes" do
        expect(record.reload.name).not_to eq('new name')
      end

      it "copies error to model" do
        expect(record.errors).not_to be_empty
      end
    end
  end
end
