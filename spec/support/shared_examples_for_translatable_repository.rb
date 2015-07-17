shared_examples "TranslatableRepository" do
  let(:repository) { described_class.new }

  it_behaves_like "any repository"

  let(:klass) { described_class.name.sub('Repository', '').constantize }
  let(:factory_name) { klass.to_s.underscore.downcase.to_sym }
  let(:locale) { "en" }

  def create_item
    create(factory_name)
  end

  def create_translation(item, locale)
    create(:translation, translatable: item, locale: locale)
  end

  describe "#all_with_translations" do
    let!(:object1) { create(factory_name) }
    let!(:object2) { create(factory_name) }

    before do
      [object1, object2].each do |o|
        %w{en ar}.each do |locale|
          repository.create_translation(o, 'val', locale)
        end
      end
    end

    subject { repository.all_with_translations("en").first.translations.first }

    it { expect(subject.locale).to eq("en") }
  end

  describe "#translation_for" do
    let(:item) { create_item }
    let(:locale) { 'en' }
    let!(:translation) { create_translation(item, locale) }

    it { is_expected.to eq(translation.value) }

    subject { repository.translation_for(item, locale) }

    context "item is blank" do
      subject { repository.translation_for(nil, locale) }

      it { is_expected.to be_nil }
    end
  end

  describe "#with_translations" do
    before do
      object = create(factory_name)
      repository.create_translation(object, 'val', locale)
    end

    subject { repository.with_translations(locale).first.translations.first }

    it { is_expected.to be_present }
  end

  describe "#find_or_create_by_translation" do
    let(:value) { "value" }

    subject { repository.find_or_create_by_translation(value, locale) }

    context "record already present" do
      let!(:object) do
        o = create(factory_name)
        repository.create_translation(o, value, locale)
        o
      end

      it { is_expected.to eq(object) }
      it { expect { subject }.not_to change { klass.count } }
    end

    context "record not yet present" do
      it do
        subject
        expected = repository.with_translations(locale).first
        is_expected.to eq(expected)
      end
      it { expect { subject }.to change { klass.count }.from(0).to(1) }
    end
  end

  describe "#find_by_translation" do
    let(:value) { "value" }

    subject { repository.find_by_translation(value, locale) }

    context "record already present" do
      let!(:object) do
        o = create(factory_name)
        repository.create_translation(o, value, locale)
        o
      end

      it { is_expected.to eq(object) }
    end

    context "record not yet present" do
      it { is_expected.to be_nil }
    end
  end

  describe "#create_with_translation" do
    let(:value) { "value" }

    subject do
      repository.create_with_translation(value, locale)
      repository.find_by_translation(value, locale)
    end

    it { is_expected.to be_present }
    it { expect { subject }.to change { klass.count } }
  end

  describe "#create_translation" do
    let(:value) { "value" }
    let!(:object) { create(factory_name) }

    subject do
      repository.create_translation(object, value, locale)
      repository.find_by_translation(value, locale)
    end

    it { is_expected.to be_present }
    it { expect { subject }.not_to change { klass.count } }
  end
end
