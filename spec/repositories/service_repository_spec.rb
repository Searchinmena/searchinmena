require "rails_helper"

describe ServiceRepository do
  let(:repository) { ServiceRepository.new }

  it_behaves_like "UserResourceRepository", :service
end
