shared_examples "Searchable By Country BusinessType Id" do |resource_name|
  describe "#search_with_country_or_business" do
    subject do
      repository.search_with_country_or_business(query, condition,
                                                                page).first
    end
    let!(:resource) do
      create(resource_name, name: "Resource Name",
                            country_id: 12)
    end
    let!(:other) { create(resource_name, name: "Other", country_id: 13) }
    let!(:same_country_data) do
      create(resource_name,
                                      name: " Alliott Hadi Shahid",
                                      country_id: 13)
    end

    let(:page) { 1 }

    before(:each) do
      resource_name.to_s.classify.constantize.reindex
    end
    context "query matches country id" do
      let(:query) { "Name" }
      let(:country_id) { 12 }
      let(:condition) { { country_id: country_id } }
      it { is_expected.to eq([resource]) }
    end

    context "query doesnot matches country_id" do
      let(:query) { "Name" }
      let(:country_id) { 13 }
      let(:condition) { { country_id: country_id } }
      it { is_expected.to eq([]) }
    end

    context "query matches business type id" do
      let(:query) { "Name" }
      let(:condition) { { business_type_ids: resource.business_type  } }
      it { is_expected.to eq([resource]) }
    end

    context "query does not match business_type id" do
      let(:query) { "Name" }
      let(:business_type_id) { 1 }
      let(:condition) { { business_type_ids: business_type_id + 1 } }
      it { is_expected.to eq([]) }
    end

    context "query match business_type id and country_id" do
      let(:query) { "Other" }
      let(:condition) do
        { business_type_ids: other.business_type,
          country_id: 13 }
      end
      it { is_expected.to eq([other]) }
    end

    context "filter result with country_id and business_type_id" do
      let(:query) { "" }
      let(:country_id) { 13 }
      let(:condition) { { country_id: 13 } }
      it { is_expected.to eq([other, same_country_data]) }
    end
  end
end
