require "rails_helper"

describe Registration::Storer do
  describe "#perform" do
    let(:service) do
      storer = Registration::Storer.new
      storer.handlers = handlers
      storer
    end

    let(:user) { double }
    let(:business) { double }

    let(:handlers) do
      2.times.map do
        double(
          perform: double(successful?: true),
          valid?: valid,
          copy_errors: nil
        )
      end
    end

    subject { service.perform(user, business) }

    context "validation passes" do
      let(:valid) { true }

      it "performs store on all handlers" do
        handlers.each do |handler|
          expect(handler).to receive(:perform)
        end
        subject
      end

      it { is_expected.to be_successful }
    end

    context "validation fails" do
      let(:valid) { false }

      it "performs copying errors on all handlers" do
        handlers.each do |handler|
          expect(handler).to receive(:copy_errors)
        end
        subject
      end

      it { is_expected.not_to be_successful }
    end
  end
end

