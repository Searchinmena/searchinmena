require "rails_helper"

describe ProductRepository do
  let(:repository) { ProductRepository.new }

  it_behaves_like "UserResourceRepository", :product
end
