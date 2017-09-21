RSpec.describe OpenAPI, "YAML constructor" do
  subject { OpenAPI.load_yaml "spec/fixtures/petstore/original.yml" }

  let(:schema) { yaml_fixture_file "petstore/original.yml" }

  it "preserves the source schema" do
    expect(subject.schema).to eq schema
  end
end
