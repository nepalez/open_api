RSpec.describe OpenAPI::Models::Response do
  let(:response) { described_class.new parent, status, source }
  let(:parent)   { double }
  let(:mapped)   { yaml_fixture_file("complex/mapped.yml") }
  let(:source)   { mapped.dig("paths", "/pets", "get", "responses", "200") }
  let(:status)   { "200" }

  describe ".new" do
    subject { response }

    it "extracts parent" do
      expect(subject.parent).to eq parent
    end

    it "extracts status" do
      expect(subject.status).to be_a OpenAPI::Models::StatusCode
      expect(subject.status).to match 200
    end

    it "extracts content" do
      expect(subject.content).to be_a OpenAPI::Models::MediaTypes
      expect(subject.content.schema("application/json"))
        .to eq source.dig("content", "application/json", "schema")
    end

    it "extracts headers" do
      expect(subject.headers).to be_a OpenAPI::Models::Headers
      expect(subject.headers.map(&:name)).to contain_exactly "X-application"
    end
  end
end
