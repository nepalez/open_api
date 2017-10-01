RSpec.describe OpenAPI::Models::MediaType do
  let(:data)   { yaml_fixture_file("uber/mapped.yml").dig(*path) }
  let(:path)   { %w[paths /me get responses 200 content application/json] }
  let(:object) { double to_s: "parameter 'user'" }
  let(:format) { "application/json" }

  subject(:type) { described_class.new object, format, data }

  describe ".new" do
    it "refers to its subject" do
      expect(subject.subject).to eq object
    end

    it "refers to its format" do
      expect(subject.format).to eq format
    end

    it "extacts the schema" do
      expect(subject.schema).to eq data["schema"]
    end
  end

  describe "#to_s" do
    it "returns a proper name" do
      expect(subject.to_s)
        .to eq "parameter 'user' formatted as application/json"
    end

    it "has an alias #to_str" do
      expect(subject.to_str).to eq subject.to_s
    end

    it "has an alias #inspect" do
      expect(subject.inspect).to eq subject.to_s
    end
  end
end
