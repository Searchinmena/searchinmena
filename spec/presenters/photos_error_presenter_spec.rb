require "rails_helper"

describe PhotosErrorPresenter do
  describe "#as_json" do
    let(:presenter) { PhotosErrorPresenter.new(file, response) }
    let(:file) { double(filename: 'ania.jpg') }
    let(:response) { double(errors: { photo: ['too big!'] }) }

    subject { presenter.as_json }

    it { is_expected.to eq(file_name: 'ania.jpg', errors: response.errors) }
  end
end
