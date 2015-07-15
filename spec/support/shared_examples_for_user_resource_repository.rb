shared_examples "UserResourceRepository" do |resource_name|
  let(:repository) { described_class.new }

  let(:user) { create(:seller) }
  let(:business) { user.business }

  it_behaves_like "any repository"

  describe "#find_for_user" do
    let(:id) { 'not existing id' }

    subject { repository.find_for_user(user, id) }

    context "object is present" do
      let!(:object) { create(resource_name, business: business) }
      let(:id) { object.id }

      it { is_expected.to eq(object) }
    end

    context "buyer user" do
      let(:user) { create(:user) }

      it { is_expected.to be_nil }
    end

    it { is_expected.to be_nil }
  end

  describe "#for_user" do
    subject { repository.for_user(user) }

    context "object is present" do
      let!(:object) { create(resource_name, business: business) }
      let(:id) { object.id }

      it { is_expected.to eq([object]) }
    end

    context "buyer user" do
      let(:user) { create(:user) }

      it { is_expected.to be_empty }
    end

    it { is_expected.to be_empty }
  end
end
