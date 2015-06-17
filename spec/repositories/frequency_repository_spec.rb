require "rails_helper"

describe FrequencyRepository do
  let(:repository) { FrequencyRepository.new }

  it_behaves_like "TranslatableRepository"
end
