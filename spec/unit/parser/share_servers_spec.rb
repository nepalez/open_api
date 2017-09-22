RSpec.describe OpenAPI::Parser::ShareServers do
  subject { described_class.call source }

  shared_examples :successful_handler do |example|
    let(:source) { yaml_fixture_file "#{example}/share_parameters.yml" }
    let(:target) { yaml_fixture_file "#{example}/share_servers.yml" }

    it "processes #{example} example" do
      expect(subject).to eq target
    end
  end

  it_behaves_like :successful_handler, "petstore"
  it_behaves_like :successful_handler, "uber"
  it_behaves_like :successful_handler, "complex"
end
