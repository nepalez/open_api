RSpec.describe OpenAPI::Models::Operation do
  let(:operation) { described_class.new source, "/pets", verb }
  let(:source)    { yaml_fixture_file("petstore/mapped.yml") }
  let(:verb)      { "get" }

  describe ".new" do
    subject { operation }

    it "extracts id" do
      expect(subject.id).to eq "findPets"
    end

    it "extracts path" do
      expect(subject.path).to eq "/pets"
    end

    it "extracts verb" do
      expect(subject.verb).to eq "get"
    end

    it "extracts deprecated" do
      expect(subject.deprecated).to eq false
    end

    it "extracts parameters" do
      expect(subject.parameters).to be_a OpenAPI::Models::Parameters
      expect(subject.parameters.first.name).to eq "tags"
    end

    it "extracts body" do
      expect(subject.body).to eq nil
    end

    it "extracts responses" do
      expect(subject.responses).to be_a OpenAPI::Models::Responses
      expect(subject.responses.first.status).to match 200
    end

    context "with content" do
      let(:verb) { "post" }

      it "extracts body" do
        expect(subject.body).to be_a OpenAPI::Models::RequestBody
      end
    end

    context "with undefiled path/verb pair" do
      let(:verb) { "put" }

      it "raises OpenAPI::Models::Error" do
        expect { subject }.to raise_error(OpenAPI::Models::Error, %r{PUT /pets})
      end
    end
  end
end
