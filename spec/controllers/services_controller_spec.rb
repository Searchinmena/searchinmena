require "rails_helper"

describe ServicesController do
  it_behaves_like "BusinessItemsController" do
    let(:creator_class) { BusinessItem::ServiceCreator }
    let(:business_item_params) do
      common_business_params.merge(
        "place_of_origin" => "origin",
        "scope_of_work" => "scope",
        "average_completion_time" => "2",
        "average_completion_time_unit_id" => "1"
      )
    end
  end
end
