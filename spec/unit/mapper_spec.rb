RSpec.describe OpenAPI::Mapper do
  subject { described_class.call source }

  shared_examples :successful_mapper do |example|
    let(:source) { yaml_fixture_file "#{example}/original.yml" }
    let(:target) { yaml_fixture_file "#{example}/share_servers.yml" }

    it "processes #{example} example" do
      expect(subject).to eq target
    end
  end

  shared_examples :errored_mapper do |example, message|
    let(:source) { yaml_fixture_file "errors/#{example}.yml" }

    it "raises an exception for #{example}" do
      expect { subject }.to raise_error(OpenAPI::Mapper::Error, message)
    end
  end

  it_behaves_like :successful_mapper, "petstore"
  it_behaves_like :successful_mapper, "uber"
  it_behaves_like :successful_mapper, "complex"
  it_behaves_like :errored_mapper,    "external_ref", /activity.yml/
end
