shared_examples "Searchable by name" do |resource_name|
  describe "#where_name_like" do
    subject { repository.where_name_like(query) }
    let!(:resource) { create(resource_name, name: "Resource Name") }

    context "query matches name from right" do
      let(:query) { 'Name' }

      it { is_expected.to eq([resource]) }
    end

    context "query matches name from left" do
      let(:query) { 'Resource' }

      it { is_expected.to eq([resource]) }
    end

    context "query matches name in the middle" do
      let(:query) { 'source Na' }

      it { is_expected.to eq([resource]) }
    end

    context "query does not match name" do
      let(:query) { 'Something else' }

      it { is_expected.to eq([]) }
    end
  end
end
