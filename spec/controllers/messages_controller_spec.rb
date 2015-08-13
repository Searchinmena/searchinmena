require "rails_helper"

describe MessagesController do
  describe "#create" do
    let(:params) { { business_id: 4, subject: 'subject', body: 'body' } }

    subject do
      post :create, { format: :json }.merge(params)
    end

    context "user is not logged in" do
      before { subject }

      it { expect(response.status).to eq(401) }
    end

    context "user is logged in" do
      let(:messages_sender) do
        double(:messages_sender, perform: sender_response)
      end
      let(:sender_response) do
        double(:sender_response,
               successful?: successful,
               object: validator)
      end
      let(:validator) { double(:validator) }
      let(:user) { create(:user) }

      before do
        sign_in(user)

        expect(controller).to receive(:messages_sender)
          .and_return(messages_sender)

        expect(messages_sender).to receive(:perform)
          .with(4, user, 'subject', 'body')

        allow(ErrorsPresenter).to receive(:new).with(validator)
      end

      context "message sent successfully" do
        let(:successful) { true }

        before { subject }

        it { expect(response).to be_successful }
      end

      context "message sent unsuccessfully" do
        let(:successful) { false }

        before do
          expect(ErrorsPresenter).to receive(:new).with(validator)
          subject
        end

        it { expect(response.status).to eq(409) }
      end
    end
  end
end

