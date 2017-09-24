RSpec.describe OpenAPI::Models::RequestBody do
  let(:object) { double to_s: "POST /pets" }
  let(:data)   { yaml_fixture_file("petstore/share_servers.yml").dig(*path) }
  let(:path)   { %w[paths /pets post requestBody] }

  let(:body) { described_class.new object, data }

  describe ".new" do
    subject { body }

    it "refers to its subject" do
      expect(subject.subject).to eq object
    end

    it "extracts the requirement" do
      expect(subject.required).to eq true
    end

    it "extacts the content" do
      expect(subject.content).to be_a OpenAPI::Models::MediaTypes
    end

    context "when requirement not defined" do
      before { data.delete "required" }

      it "is not required" do
        expect(subject.required).to eq false
      end
    end

    context "without content" do
      before { data.delete "content" }

      it "raises OpenAPI::Models::Error" do
        expect { subject }.to raise_error OpenAPI::Models::Error, /content/
      end
    end
  end

  describe "#to_s" do
    subject { body }

    it "returns a proper name" do
      expect(subject.to_s).to eq "request body of POST /pets"
    end

    it "has an alias #to_str" do
      expect(subject.to_str).to eq subject.to_s
    end

    it "has an alias #inspect" do
      expect(subject.inspect).to eq subject.to_s
    end
  end

  describe "#schema" do
    subject { body.schema(type) }

    context "with registered type" do
      let(:type) { :"application/json" }

      it "returns media type schema" do
        expect(subject).to eq data.dig("content", "application/json", "schema")
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
