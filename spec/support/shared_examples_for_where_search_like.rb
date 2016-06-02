shared_examples "AutoSearchable by name" do |resource_name|
  describe "#where_search_like" do
    subject { repository.where_search_like(resource_name, query).last.records }
    let!(:resource) { create(resource_name, name: "Resource Name") }
    let!(:other) { create(resource_name, name: "Other") }
    before(:each) do
      Tag.reindex
      ServiceCategory.reindex
      ProductCategory.reindex
      resource_name.to_s.classify.constantize.reindex
    end
    context "query does not matches name from right" do
      let(:query) { "Name" }

      it { is_expected.to eq([]) }
    end

    context "query matches name from left" do
      let(:query) { "Resource" }

      it { is_expected.to eq([resource]) }
    end

    context "query matches name in the middle" do
      let(:query) { "source Na" }

      it { is_expected.to eq([]) }
    end

    context "query does not match name" do
      let(:query) { "Resource Other" }

      it { is_expected.to eq([]) }
    end

    context "query does not match name" do
      let(:query) { "Something else" }

      it { is_expected.to eq([]) }
    end

    context "query is empty" do
      let(:query) { "" }

      it { is_expected.to eq([resource, other]) }
    end
  end
end
