require "spec_helper"

describe ApiConstraints do
  let(:api_constraints_v1) { ApiConstraints.new(version: 1) }
  let(:api_constraints_v2) { ApiConstraints.new(version: 2, default: true) }

  describe "matches?" do
    it "returns true when version matches the 'Accept' header" do
      request = double(host: 'api.brasil-sem-zika.dev', headers: { "Accept" => "application/vnd.brasilsemzika.v1" })
      expect(api_constraints_v1.matches?(request)).to be_truthy
    end

    it "return the default version when 'default' options is speficied" do
      request = double(host: 'api.brazil-sem-zika.dev')
      expect(api_constraints_v2.matches?(request)).to be_truthy
    end
  end

end
