RSpec.describe OpenAPI::Models::Headers do
  let(:list)   { described_class.new source, parent }
  let(:parent) { double }
  let(:mapped) { yaml_fixture_file("complex/mapped.yml") }
  let(:source) do
    mapped.dig "paths", "/pets", "get", "responses", "200", "headers"
  end

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

    it "iterates by parameters" do
      expect(list.map(&:class).uniq)
        .to contain_exactly OpenAPI::Models::Parameter

      expect(list.map(&:name)).to contain_exactly "X-application"
      expect(list.map(&:location)).to contain_exactly "header"
      expect(list.map(&:schema)).to contain_exactly "type" => "string"
    end
  end
end
