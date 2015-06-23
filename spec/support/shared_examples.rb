shared_examples_for "redirects to signin if user not logged in" do
  context "user is not logged in" do
    it "redirects to login page" do
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

shared_context "photo validation" do |model_name, field_name|
  describe "photo validation" do
    let(:model) { build(model_name) }
    let(:params) { build_params(model, field_name => file) }
    let(:file) do
      double(content_type: content_type, size: size)
    end
    let(:content_type) { PhotoValidator::VALID_CONTENT_TYPES.first }
    let(:size) { FileValidator::MAX_FILE_SIZE_IN_MB - 1 }

    subject { described_class.new(params) }

    it { is_expected.to be_valid }

    context "file has invalid extension" do
      let(:content_type) { 'audio/x-aac' }

      it { is_expected.not_to be_valid }
    end

    context "file is too large" do
      let(:size) { 6.megabytes }

      it { is_expected.not_to be_valid }
    end
  end
end
