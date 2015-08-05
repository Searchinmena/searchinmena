shared_examples "CategoryRepository" do |resource_name|
  describe "#update_parent" do
    let(:category) { build(resource_name) }
    let(:parent) { create(resource_name) }

    before { repository.update_parent(category, parent) }

    it { expect(category.reload.parent).to eq(parent) }
  end

  describe "#for_parent_id" do
    let!(:parent) { create(resource_name) }
    let!(:category) { create(resource_name, parent: parent) }

    before do
      [parent, category].each do |o|
        %w{en ar}.each do |locale|
          repository.create_translation(o, "val", locale)
        end
      end
    end

    subject do
      repository.for_parent_id(parent.id, "en").first.translations.first
    end

    it { expect(subject.locale).to eq("en") }
  end

  describe "#hierarchy_for" do
    subject { repository.hierarchy_for(category) }

    let(:category) { create(resource_name, parent: parent) }
    let(:parent) { create(resource_name, parent: grand_parent) }
    let(:grand_parent) { create(resource_name, parent: grand_grand_parent) }
    let(:grand_grand_parent) { create(resource_name) }

    it do
      is_expected.to eq([grand_grand_parent, grand_parent,
                         parent, category])
    end
  end

  describe "#translation_for" do
    subject { repository.translation_for(category, locale) }

    let(:category) do
      create(resource_name, category_translations: [category_translation])
    end
    let(:locale) { "en" }
    let(:category_translation) { create(:category_translation, locale: "en") }

    it { is_expected.to eq(category_translation.value) }
  end
end
