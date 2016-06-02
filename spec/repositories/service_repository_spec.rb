require "rails_helper"

describe ServiceRepository do
  let(:repository) { ServiceRepository.new }
  let(:photos_repository) { ServicePhotoRepository.new }

  it_behaves_like "UserResourceRepository", :service
  it_behaves_like "BusinessItemRepository"
  it_behaves_like "Searchable by name", :service
  it_behaves_like "AutoSearchable by name", :service
end
