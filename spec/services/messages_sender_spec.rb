require "rails_helper"

describe MessagesSender do
  describe "#perform" do
    let(:sender) { MessagesSender.new(validator_factory, message_formatter) }
    let(:validator_factory) { double(:validator_factory, new: validator) }
    let(:message_formatter) do
      double(:messasage_formatter, perform: formatted_body)
    end
    let(:formatted_body) { "formatted body" }
    let(:validator) { double(:validator, valid?: valid) }

    subject { sender.perform(business_id, user, message_subject, message_body) }

    let(:business) { create(:business) }
    let(:business_id) { business.id }
    let(:user) { create(:user) }
    let(:message_subject) { 'subject' }
    let(:message_body) { 'body' }
    let(:valid) { true }

    context "user is blank" do
      let(:user) { nil }

      it { is_expected.not_to be_successful }
    end

    context "business not found" do
      let(:business_id) { 'not existing id' }

      it { is_expected.not_to be_successful }
    end

    context "message not valid" do
      let(:valid) { false }

      it { is_expected.not_to be_successful }
      it { expect(subject.object).to eq(validator) }
    end

    it do
      expect(UserMailer).to receive(:contact_seller)
        .with(business.user, message_subject, formatted_body)
        .and_return(double(:mailer, deliver_now: nil))
      expect(UserMailer).to receive(:message_confirmation)
        .with(business, user, message_subject, formatted_body)
        .and_return(double(:mailer, deliver_now: nil))
      subject
    end

    it { is_expected.to be_successful }
  end
end
