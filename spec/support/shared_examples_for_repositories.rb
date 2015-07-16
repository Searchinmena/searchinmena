shared_examples "any repository" do
  let(:klass) { described_class.name.sub('Repository', '').constantize }
  let(:factory_name) { klass.to_s.underscore.downcase.to_sym }

  describe "#new" do
    it { expect(subject.new).to be_an_instance_of klass }
  end

  describe "#find_by_id" do
    let!(:object) { create(factory_name) }
    it { expect(subject.find_by_id(object.id)).to eq(object)  }
  end

  describe "#all" do
    let!(:object_1) { create(factory_name) }
    let!(:object_2) { create(factory_name) }
    it { expect(subject.all).to eq([object_1, object_2])  }
  end

  describe "#first" do
    let!(:object_1) { create(factory_name) }
    let!(:object_2) { create(factory_name) }
    it { expect(subject.first).to eq(object_1)  }
  end

  describe "#last" do
    let!(:object_1) { create(factory_name) }
    let!(:object_2) { create(factory_name) }
    it { expect(subject.last).to eq(klass.last)  }
  end

  describe "#count" do
    let!(:object_1) { create(factory_name) }
    let!(:object_2) { create(factory_name) }
    it { expect(subject.count).to eq(2)  }
  end

  describe "#save" do
    let(:object) { build(factory_name) }
    it { expect { subject.save(object) }.to change { subject.all.size } }
  end

  describe "#update" do
    let!(:object) { create(factory_name) }
    let(:params) { { id: object.id + 1000 } }
    it do
      expect { subject.update(object, params) }.to change { object.id }
    end
  end

  describe "#destroy" do
    let!(:object) { create(factory_name) }
    it { expect { subject.destroy(object) }.to change { subject.all.size } }
  end

  describe "#find_or_create" do
    let(:attributes) { build_params(build(factory_name)) }

    subject { repository.find_or_create(attributes) }

    context "record already present" do
      let!(:object) { create(factory_name, attributes) }

      it { is_expected.to eq(object) }
      it { expect { subject }.not_to change { klass.count } }
    end

    context "record not yet present" do
      it { is_expected.to eq(klass.where(attributes).first) }
      it { expect { subject }.to change { klass.count }.from(0).to(1) }
    end
  end

  describe "#find_or_build" do
    let(:attributes) { build_params(build(factory_name)) }

    subject { repository.find_or_build(attributes) }

    it { expect(subject.attributes).to eq(attributes) }

    context "record alredy present" do
      let!(:object) { create(factory_name, attributes) }

      it { is_expected.to eq(object) }
    end
  end
end
