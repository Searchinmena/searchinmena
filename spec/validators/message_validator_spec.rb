require "rails_helper"

describe MessageValidator do
  subject { described_class.new(message_params) }

  let(:message_params) { valid_params }
  let(:valid_params) { { subject: 'Subject', body: 'Body' } }

  describe "#subject" do
    context "too long" do
      let(:message_params) do
        too_long_field = "a" * (A9n.validations[:max_text_field_size] + 1)
        valid_params.merge(subject: too_long_field)
      end

      it { is_expected.to be_invalid }
    end

    context "not present" do
      let(:message_params) do
        valid_params.merge(subject: nil)
      end

      it { is_expected.to be_invalid }
    end
  end

  describe "#body" do
    context "too long" do
      let(:message_params) do
        too_long_field = "a" * (A9n.validations[:max_text_area_size] + 1)
        valid_params.merge(body: too_long_field)
      end

      it { is_expected.to be_invalid }
    end

    context "not present" do
      let(:message_params) do
        valid_params.merge(body: nil)
      end

      it { is_expected.to be_invalid }
    end
  end
end

