require "rails_helper"

describe ServicePhotoRepository do
  let(:repository) { ServicePhotoRepository.new }

  it_behaves_like "PhotoRepository"
  it_behaves_like "ServiceResourceRepository"
end
