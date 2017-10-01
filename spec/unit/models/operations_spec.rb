RSpec.describe OpenAPI::Models::Operations do
  let(:list)   { described_class.new source }
  let(:source) { yaml_fixture_file("petstore/mapped.yml") }

  describe "#each" do
    it "return enumerator" do
      expect(list.each).to be_a Enumerator
    end

    it "iterates by operations" do
      expect(list.map(&:class).uniq)
        .to contain_exactly OpenAPI::Models::Operation
      expect(list.map(&:id))
        .to contain_exactly "addPet", "deletePet", "findPet", "findPets"
    end
  end
end
