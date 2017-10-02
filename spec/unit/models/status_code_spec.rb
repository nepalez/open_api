RSpec.describe OpenAPI::Models::StatusCode do
  subject { described_class.call status, double(to_str: "GET /pets") }

  context "default code" do
    let(:status) { "default" }

    its(:order) { is_expected.to eq 2 }

    it "matches status within the range of 100-599" do
      expect(subject.match(422)).to eq true
    end

    it "doesn't match statuses out of the range 100-599" do
      expect(subject.match(600)).to eq false
    end
  end

  context "range of codes" do
    let(:status) { "4XX" }

    its(:order) { is_expected.to eq 1 }

    it "matches status within the range" do
      expect(subject.match(422)).to eq true
    end

    it "doesn't match statuses out of the range" do
      expect(subject.match(302)).to eq false
    end
  end

  context "exact code (integer)" do
    let(:status) { 422 }

    its(:order) { is_expected.to eq 0 }

    it "matches exact status" do
      expect(subject.match(422)).to eq true
    end

    it "doesn't match other statuses" do
      expect(subject.match(419)).to eq false
    end
  end

  context "exact code (string)" do
    let(:status) { "422" }

    its(:order) { is_expected.to eq 0 }

    it "matches exact status" do
      expect(subject.match(422)).to eq true
    end

    it "doesn't match other statuses" do
      expect(subject.match(419)).to eq false
    end
  end

  context "invalid code" do
    let(:status) { "600" }

    it "raises OpenAPI::Models::Error" do
      expect { subject }.to raise_error(OpenAPI::Models::Error, /600/)
    end
  end

  context "invalid range" do
    let(:status) { "7XX" }

    it "raises OpenAPI::Models::Error" do
      expect { subject }.to raise_error(OpenAPI::Models::Error, /7XX/)
    end
  end
end
