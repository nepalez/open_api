RSpec.describe OpenAPI::Models::Location do
  subject { described_class.new(object, source) }

  let(:source) { "query" }
  let(:object) { double to_s: "GET /users" }

  it "refers to its subject instance" do
    expect(subject.subject).to eq object
  end

  context "query" do
    it { is_expected.to be_query }
    it { is_expected.to be_security }
    it { is_expected.not_to be_cookie }
    it { is_expected.not_to be_header }
    it { is_expected.not_to be_path }
    it { is_expected.not_to be_required }
  end

  context "path" do
    let(:source) { "path" }

    it { is_expected.to be_path }
    it { is_expected.to be_required }
    it { is_expected.not_to be_security }
    it { is_expected.not_to be_cookie }
    it { is_expected.not_to be_header }
    it { is_expected.not_to be_query }
  end

  context "header" do
    let(:source) { "header" }

    it { is_expected.to be_header }
    it { is_expected.to be_security }
    it { is_expected.not_to be_cookie }
    it { is_expected.not_to be_query }
    it { is_expected.not_to be_path }
    it { is_expected.not_to be_required }
  end

  context "cookie" do
    let(:source) { "cookie" }

    it { is_expected.to be_cookie }
    it { is_expected.to be_security }
    it { is_expected.not_to be_header }
    it { is_expected.not_to be_path }
    it { is_expected.not_to be_query }
    it { is_expected.not_to be_required }
  end

  context "unknown location" do
    let(:source) { "body" }

    it "raises exception" do
      expect { subject }.to raise_error(ArgumentError, /body/)
    end
  end
end
