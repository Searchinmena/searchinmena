require "rails_helper"

describe ProductRepository do
  let(:repository) { ProductRepository.new }
  let(:photos_repository) { ProductPhotoRepository.new }

  it_behaves_like "UserResourceRepository", :product
  it_behaves_like "BusinessItemRepository"
end
