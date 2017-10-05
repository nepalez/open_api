RSpec.describe OpenAPI::Models::Responses do
  let(:list)   { described_class.call source, parent }
  let(:parent) { double }
  let(:mapped) { yaml_fixture_file("petstore/mapped.yml") }
  let(:source) { mapped.dig("paths", "/pets", "get", "responses") }

  describe ".new" do
    subject { list }

    it "sets reference to the <parent> operation" do
      expect(subject.parent).to eq parent
    end
  end

  describe "#each" do
    it "return enumerator" do
      expect(list.each).to be_a Enumerator
    end

    it "iterates by responses" do
      expect(list.map(&:class).uniq)
        .to contain_exactly OpenAPI::Models::Response

      expect(list.map(&:order)).to contain_exactly 0, 2
    end
  end

  describe "#[]" do
    it "finds a parameter by status" do
      response = list[200]
      expect(response).to be_a OpenAPI::Models::Response
      expect(response.status.code).to eq "200"
    end

    it "returns default response when no response was found" do
      response = list[100]
      expect(response.status.code).to eq "default"
    end
  end

  describe "#select" do
    subject { list.select { |item| item.match 400 } }

    it "returns another collection of responses" do
      expect(subject).to be_a OpenAPI::Models::Responses
    end

    it "preserves parent" do
      expect(subject.parent).to eq parent
    end

    it "selects proper responses" do
      expect(subject.map(&:status).map(&:code)).to contain_exactly "default"
    end
  end

  describe "#reject" do
    subject { list.reject { |item| item.match 400 } }

    it "returns another collection of responses" do
      expect(subject).to be_a OpenAPI::Models::Responses
    end

    it "preserves parent" do
      expect(subject.parent).to eq parent
    end

    it "selects proper responses" do
      expect(subject.map(&:status).map(&:code)).to contain_exactly "200"
    end
  end
end
