RSpec.describe OpenAPI::Models::MediaTypes do
  let(:data)   { yaml_fixture_file("uber/mapped.yml").dig(*path) }
  let(:path)   { %w[paths /me get responses 200 content] }
  let(:parent) { double to_s: "parameter 'user'" }
  let(:types)  { described_class.call data, parent }

  describe ".call" do
    subject { types }

    it "refers to the parent" do
      expect(subject.parent).to eq parent
    end
  end

  describe "#each" do
    subject { types.each }

    it "returns enumerator" do
      expect(subject).to be_a Enumerator
    end

    it "iterates by media types" do
      expect(subject.count).to eq 1
      expect(subject.map(&:class)).to eq [OpenAPI::Models::MediaType]
      expect(subject.map(&:format)).to eq data.keys
    end
  end

  describe "#[]" do
    subject { types[type] }

    context "with registered type" do
      let(:type) { :"application/json" }

      it "returns media type object" do
        expect(subject.format).to eq "application/json"
      end
    end

    context "with unknown type" do
      let(:type) { :"text/html" }

      it "raises OpenAPI::Models::Error" do
        expect { subject }.to raise_error OpenAPI::Models::Error, %r{text/html}
      end
    end
  end

  describe "#schema" do
    subject { types.schema(type) }

    context "with registered type" do
      let(:type) { :"application/json" }

      it "returns media type schema" do
        expect(subject).to eq data.dig("application/json", "schema")
      end
    end

    context "with unknown type" do
      let(:type) { :"text/html" }

      it "raises OpenAPI::Models::Error" do
        expect { subject }.to raise_error OpenAPI::Models::Error, %r{text/html}
      end
    end
  end
end
