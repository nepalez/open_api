RSpec.describe OpenAPI::Models::Parameters do
  let(:list)   { described_class.new source, parent }
  let(:parent) { double }
  let(:parsed) { yaml_fixture_file("petstore/share_servers.yml") }
  let(:source) { parsed.dig "paths", "/pets", "get", "parameters" }

  describe ".new" do
    subject { list }

    it "sets reference to the <parent> operation" do
      expect(subject.operation).to eq parent
    end
  end

  describe "#each" do
    it "return enumerator" do
      expect(list.each).to be_a Enumerator
    end

    it "iterates by parameters" do
      expect(list.map(&:class).uniq)
        .to contain_exactly OpenAPI::Models::Parameter

      expect(list.map(&:name)).to contain_exactly "limit", "tags"
    end
  end
end
