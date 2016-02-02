# require "rails_helper"
#
# describe SearchController do
#   describe "#create" do
#     let(:business) { create(:business) }
#     let(:type) { "product" }
#     let(:query) { "some product" }
#     let(:search_service) { double(:search_service) }
#     let(:search_response) { Search::Response.new(success: successful) }
#
#     before do
#       expect(controller).to receive(:search_service)
#         .and_return(search_service)
#       expect(search_service).to receive(:perform)
#         .with(type, query).and_return(search_response)
#
#       get :index, type: type, query: query
#     end
#
#     context "search is successful" do
#       let(:successful) { true }
#
#       it { expect(response).to be_successful }
#     end
#
#     context "search is not successful" do
#       let(:successful) { false }
#
#       it { expect(response).not_to be_successful }
#     end
#   end
# end
