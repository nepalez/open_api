RSpec.describe OpenAPI::Models::Parameter do
  let(:param)  { described_class.new parent, source }
  let(:parent) { double }
  let(:data)   { yaml_fixture_file("petstore/share_servers.yml") }
  let(:source) { data.dig("paths", "/pets", "get", "parameters").last }

  describe ".new" do
    subject { param }

    it "refers to operation" do
      expect(subject.operation).to eq parent
    end

    it "extacts name" do
      expect(subject.name).to eq "limit"
    end

    it "extacts a location" do
      expect(subject.location).to be_a OpenAPI::Models::Location
      expect(subject.location).to be_query
      expect(subject.location.subject).to eq subject
    end

    it "extacts required" do
      expect(subject).not_to be_required
    end

    it "extacts deprecated" do
      expect(subject.deprecated).to eq false
    end

    it "extacts empty" do
      expect(subject).not_to be_empty
    end

    it "extracts schema" do
      expect(subject.schema).to eq "type" => "integer", "format" => "int32"
    end

    it "tells about location" do
      expect(subject).to     be_query
      expect(subject).not_to be_path
      expect(subject).not_to be_header
      expect(subject).not_to be_cookie
    end

    context "when 'required' not defined" do
      before { source.delete "required" }

      it "sets required to false" do
        expect(subject).not_to be_required
      end

      context "and location is a 'path'" do
        before { source["in"] = "path" }

        it "sets required to true" do
          expect(subject).to be_required
        end
      end
    end

    context "without a name" do
      before { source.delete "name" }

      it "raises OpenAPI::Models::Error" do
        expect { subject }.to raise_error(OpenAPI::Models::Error, /name/)
      end
    end

    context "without a location" do
      before { source.delete "in" }

      it "raises OpenAPI::Models::Error" do
        expect { subject }.to raise_error(OpenAPI::Models::Error, /in/)
      end
    end
  end
end
