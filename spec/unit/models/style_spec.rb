RSpec.describe OpenAPI::Models::Style do
  subject { described_class.new(object, source) }

  let(:object) { double to_s: "GET /users" }
  let(:source) { "matrix" }

  it "refers to the described subject" do
    expect(subject.subject).to eq object
  end

  context "matrix" do
    it { is_expected.to eq source }
    it { is_expected.to be_defined }
    it { is_expected.to be_path }
    it { is_expected.not_to be_cookie }
    it { is_expected.not_to be_header }
    it { is_expected.not_to be_query }
  end

  context "matrix" do
    let(:source) { "label" }

    it { is_expected.to eq source }
    it { is_expected.to be_defined }
    it { is_expected.to be_path }
    it { is_expected.not_to be_cookie }
    it { is_expected.not_to be_header }
    it { is_expected.not_to be_query }
  end

  context "form" do
    let(:source) { "form" }

    it { is_expected.to eq source }
    it { is_expected.to be_defined }
    it { is_expected.to be_cookie }
    it { is_expected.to be_query }
    it { is_expected.not_to be_header }
    it { is_expected.not_to be_path }
  end

  context "simple" do
    let(:source) { "simple" }

    it { is_expected.to eq source }
    it { is_expected.to be_defined }
    it { is_expected.to be_header }
    it { is_expected.to be_path }
    it { is_expected.not_to be_cookie }
    it { is_expected.not_to be_query }
  end

  context "spaceDelimited" do
    let(:source) { "spaceDelimited" }

    it { is_expected.to eq source }
    it { is_expected.to be_defined }
    it { is_expected.to be_query }
    it { is_expected.not_to be_cookie }
    it { is_expected.not_to be_header }
    it { is_expected.not_to be_path }
  end

  context "pipeDelimited" do
    let(:source) { "spaceDelimited" }

    it { is_expected.to eq source }
    it { is_expected.to be_defined }
    it { is_expected.to be_query }
    it { is_expected.not_to be_cookie }
    it { is_expected.not_to be_header }
    it { is_expected.not_to be_path }
  end

  context "deepObject" do
    let(:source) { "deepObject" }

    it { is_expected.to eq source }
    it { is_expected.to be_defined }
    it { is_expected.to be_query }
    it { is_expected.not_to be_cookie }
    it { is_expected.not_to be_header }
    it { is_expected.not_to be_path }
  end

  context "n/a" do
    let(:source) { "n/a" }

    it { is_expected.to eq source }
    it { is_expected.not_to be_defined }
    it { is_expected.to be_query }
    it { is_expected.to be_cookie }
    it { is_expected.to be_header }
    it { is_expected.to be_path }
  end

  context "nil" do
    let(:source) { nil }

    it { is_expected.to eq "n/a" }
    it { is_expected.not_to be_defined }
    it { is_expected.to be_query }
    it { is_expected.to be_cookie }
    it { is_expected.to be_header }
    it { is_expected.to be_path }
  end

  context "unknown source" do
    let(:source) { "foo" }

    it "raises exception" do
      expect { subject }.to raise_error(ArgumentError, /foo/)
    end
  end
end
