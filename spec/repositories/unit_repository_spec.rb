require "rails_helper"

describe UnitRepository do
  let(:repository) { UnitRepository.new }

  it_behaves_like "TranslatableRepository"
end
