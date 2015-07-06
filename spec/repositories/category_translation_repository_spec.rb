require "rails_helper"

describe CategoryTranslationRepository do
  let(:repository) { CategoryTranslationRepository.new }

  it_behaves_like "any repository"
end
