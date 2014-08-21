require "spec_helper"

describe EnumeratedType do
  describe "I18n" do
    it "returns an internationalized name" do
      allow(I18n).to receive(:translate!)
        .with(:finished, scope: [:enumerated_type, "status"])
        .and_return("finito")

      expect(Status[:finished].human).to eq "finito"
    end

    it "defaults to the name" do
      expect(Status[:finished].human).to eq "Finished"
    end
  end
end
