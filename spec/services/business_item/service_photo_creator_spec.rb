require 'rails_helper'

describe BusinessItem::ServicePhotoCreator do
  it_behaves_like "business item photo creator" do
    let(:repository) { ServicePhotoRepository.new }
    let(:business_item) { create(:service) }
  end
end
