require "rails_helper"

describe ErrorsPresenter do
  describe "#as_json" do
    let(:presenter) { ErrorsPresenter.new(record) }
    let(:record) { double(errors: double(messages: error_messages)) }
    let(:error_messages) { { name: %w{message1 message2} } }

    subject { presenter.as_json }

    it "returns first error for each field" do
      is_expected.to eq(name: "message1")
    end
  end
end
