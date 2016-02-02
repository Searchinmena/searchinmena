# require "rails_helper"
#
# describe Search::ResultPresenterFactory do
#   let(:factory) do
#     Search::ResultPresenterFactory.new(
#       product_repository,
#       product_photo_repository,
#       service_repository,
#       service_photo_repository,
#       business_repository
#     )
#   end
#
#   fake(:product_repository)
#   fake(:product_photo_repository)
#   fake(:service_repository)
#   fake(:service_photo_repository)
#   fake(:business_repository)
#
#   describe "#build" do
#     subject { factory.build(result, locale) }
#
#     let(:locale) { "en" }
#
#     context "builds presenter for product" do
#       let(:result) { build(:product) }
#
#       it { expect(subject.class).to eq(ProductResultPresenter) }
#       it { expect(subject.key).to eq(:product) }
#     end
#
#     context "builds presenter for service" do
#       let(:result) { build(:service) }
#
#       it { expect(subject.class).to eq(ServiceResultPresenter) }
#       it { expect(subject.key).to eq(:service) }
#     end
#
#     context "builds presenter for business" do
#       let(:result) { build(:business) }
#
#       it { expect(subject.class).to eq(BusinessResultPresenter) }
#       it { expect(subject.key).to eq(:business) }
#     end
#   end
# end
#
