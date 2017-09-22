RSpec.describe OpenAPI::Parser do
  subject { described_class.call source }

  shared_examples :successful_handler do |example|
    let(:source) { yaml_fixture_file "#{example}/original.yml" }
    let(:target) { yaml_fixture_file "#{example}/share_servers.yml" }

    it "processes #{example} example" do
      expect(subject).to eq target
    end
  end

  shared_examples :errored_handler do |example, message|
    let(:source) { yaml_fixture_file "errors/#{example}.yml" }

    it "raises an exception for #{example}" do
      expect { subject }.to raise_error(OpenAPI::Parser::Error, message)
    end
  end

  it_behaves_like :successful_handler, "petstore"
  it_behaves_like :successful_handler, "uber"
  it_behaves_like :successful_handler, "complex"
  it_behaves_like :errored_handler,    "external_ref", /activity.yml/
end
