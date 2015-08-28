require "rails_helper"

describe Business::Saver do
  fake(:base_business_saver)
  fake(:user_category_service)

  let(:photos_storing_handler) do
    double(:photos_storing_handler, photos: [], valid?: true)
  end
  let(:handlers) do
    [base_business_saver, photos_storing_handler, user_category_service]
  end
  let(:user) { build(:user) }
  let(:business) { build(:business) }
  let(:photos) { photos_storing_handler.photos }
  let(:response) { double(:response, successful?: true) }

  let(:saver) do
    described_class.new(handlers, business, photos)
  end

  describe "#perform" do
    subject { saver.perform }

    it "calls perform on each handler" do
      handlers.each do |handler|
        expect(handler).to receive(:perform)
          .and_return(response)
      end

      is_expected.to be_successful
    end
  end
end
