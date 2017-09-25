RSpec.describe OpenAPI::Models::Style do
  let(:style)     { described_class.new(object, source) }
  let(:object)    { double to_s: parameter, location: location }
  let(:parameter) { "path parameter 'id' of GET /users/:id" }
  let(:source)    { "matrix" }
  let(:location)  { OpenAPI::Models::Location.new(double, loc) }
  let(:loc)       { "path" }

  subject { style }

  it "refers to the described subject" do
    expect(subject.subject).to eq object
  end

  context "default for path subject" do
    let(:source) { nil }
    let(:loc)    { "path" }
    it { is_expected.to eq "simple" }
  end

  context "default for query subject" do
    let(:source) { nil }
    let(:loc)    { "query" }
    it { is_expected.to eq "form" }
  end

  context "default for header subject" do
    let(:source) { nil }
    let(:loc)    { "header" }
    it { is_expected.to eq "simple" }
  end

  context "default for cookie subject" do
    let(:source) { nil }
    let(:loc)    { "cookie" }
    it { is_expected.to eq "form" }
  end

  context "matrix" do
    let(:source)  { "matrix" }
    let(:loc)     { "path" }
    it { is_expected.not_to be_explode }
    its(:types)   { is_expected.to match_array %w[primitive array object] }
  end

  context "label" do
    let(:source)  { "label" }
    let(:loc)     { "path" }
    it { is_expected.not_to be_explode }
    its(:types)   { is_expected.to match_array %w[primitive array object] }
  end

  context "form" do
    let(:source)  { "form" }
    let(:loc)     { "query" }
    it { is_expected.to be_explode }
    its(:types)   { is_expected.to match_array %w[primitive array object] }
  end

  context "simple" do
    let(:source)  { "simple" }
    let(:loc)     { "path" }
    it { is_expected.not_to be_explode }
    its(:types)   { is_expected.to match_array %w[array] }
  end

  context "spaceDelimited" do
    let(:source)  { "spaceDelimited" }
    let(:loc)     { "query" }
    it { is_expected.not_to be_explode }
    its(:types)   { is_expected.to match_array %w[array] }
  end

  context "pipeDelimited" do
    let(:source)  { "pipeDelimited" }
    let(:loc)     { "query" }
    it { is_expected.not_to be_explode }
    its(:types)   { is_expected.to match_array %w[array] }
  end

  context "deepObject" do
    let(:source)  { "deepObject" }
    let(:loc)     { "query" }
    it { is_expected.not_to be_explode }
    its(:types)   { is_expected.to match_array %w[object] }
  end

  context "source inconsistent to subject location" do
    let(:loc)    { "cookie" }
    let(:source) { "matrix" } # for path only

    it "raises exception" do
      expect { subject }.to raise_error(ArgumentError, /matrix/)
    end
  end

  context "unknown source" do
    let(:source) { "foo" }

    it "raises exception" do
      expect { subject }.to raise_error(ArgumentError, /foo/)
    end
  end
end
