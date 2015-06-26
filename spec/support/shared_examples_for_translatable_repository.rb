shared_examples "TranslatableRepository" do
  it_behaves_like "any repository"

  describe "#all_with_translations" do
    let(:klass) { described_class.name.sub('Repository', '').constantize }
    let(:factory_name) { klass.to_s.underscore.downcase.to_sym }

    let!(:object1) { create(factory_name) }
    let!(:object2) { create(factory_name) }

    before do
      [object1, object2].each do |o|
        %w{en ar}.each do |locale|
          create(:translation, key: o.key, locale: locale)
        end
      end
    end

    let(:repository) { described_class.new }

    subject { repository.all_with_translations("en").first.translations.first }

    it { expect(subject.key).to eq(object1.key) }
    it { expect(subject.locale).to eq("en") }
  end
end
