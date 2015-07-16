require "rails_helper"

describe ServicesController do
  it_behaves_like "BusinessItemsController", :service do
    let(:repository) { ServiceRepository.new }
    let(:creator_class) { BusinessItem::ServiceCreator }
    let(:business_item_params) do
      common_business_params.merge(
        "place_of_origin" => "origin",
        "scope_of_work" => "scope",
        "average_completion_time" => "2",
        "average_completion_time_unit_id" => "1"
      )
    end
    let(:business_item) { create(:service, business: user.business) }
  end
end
