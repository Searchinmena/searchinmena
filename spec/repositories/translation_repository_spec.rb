require "rails_helper"

describe TranslationRepository do
  let(:repository) { TranslationRepository.new }

  it_behaves_like "each Repository"
end
