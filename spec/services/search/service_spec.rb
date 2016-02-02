# require "rails_helper"
#
# describe Search::Service do
#   let(:search_service) { Search::Service.new(search_strategy_factory) }
#   let(:search_strategy_factory) do
#     double(:search_strategy_factory, build: search_strategy)
#   end
#   let(:search_strategy) { double(:search_strategy, perform: nil) }
#
#   describe "#perform" do
#     subject { search_service.perform(type, query) }
#
#     let(:type) { 'product' }
#     let(:query) { 'query' }
#
#     it "runs proper strategy" do
#       expect(search_strategy).to receive(:perform)
#       subject
#     end
#   end
# end
#
