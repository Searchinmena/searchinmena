require "rails_helper"

describe ProductPhotoRepository do
  let(:repository) { ProductPhotoRepository.new }

  it_behaves_like "PhotoRepository"
end
