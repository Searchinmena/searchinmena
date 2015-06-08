require 'rails_helper'

describe Registration::Creator do
  describe "#perform" do
    let(:service) do
      Registration::Creator.new(registration_params)
    end
    fake(:storer_factory) { Registration::StorerFactory }
    let(:user_repository) { double(new: user) }
    let(:business_repository) { double(new: business) }
    fake(:storer) { Registration::SellerStorer }

    let(:registration_params) do
      {
        user: { category: category },
        business: {},
        tags: {}
      }
    end

    let(:user) { double(:user) }
    let(:business) { double(:business) }
    let(:category) { 'seller' }

    it "performs storer with correct args" do
      expect(service).to receive(:user_repository)
        .and_return(user_repository)
      expect(service).to receive(:business_repository)
        .and_return(business_repository)
      expect(service).to receive(:storer_factory)
        .and_return(storer_factory)

      expect(user_repository).to receive(:setup)
      .with(registration_params[:user]).and_return(user)

      expect(storer_factory).to receive(:from_category)
        .with(category, { user: user, business: business }, registration_params)
        .and_return(storer)

      expect(storer).to receive(:perform).with(user, business)
      service.perform
    end
  end
end
