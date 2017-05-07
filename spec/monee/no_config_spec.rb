require "spec_helper"

RSpec.describe Monee::NoConfig do
  context "Default config" do
    let(:no_config) { Monee::Currency.config }

    it "has a base_currency" do
      expect(no_config.base_currency).to eq('EUR')
    end

    it "has a currency_rates" do
      expect(no_config.currency_rates).not_to be_empty
    end

    it "has available currencies" do
      expect(no_config.available_currencies).to match_array(%w(EUR USD Bitcoin))
    end
  end
end
