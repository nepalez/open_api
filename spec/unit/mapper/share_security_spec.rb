RSpec.describe OpenAPI::Mapper::ShareSecurity do
  subject { described_class.call source }

  shared_examples :successful_mapper do |example|
    let(:source) { yaml_fixture_file "#{example}/share_parameters.yml" }
    let(:target) { yaml_fixture_file "#{example}/share_security.yml" }

    it "processes #{example} example" do
      expect(subject).to eq target
    end
  end

  it_behaves_like :successful_mapper, "petstore"
  it_behaves_like :successful_mapper, "uber"
  it_behaves_like :successful_mapper, "complex"
end
