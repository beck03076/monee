require "spec_helper"

RSpec.describe Monee::Config do

  context "Default config" do
    let(:config) { Monee::Currency.config }

    it "has a base_currency" do
      expect(config.base_currency).to eq('EUR')
    end

    it "has a currency_rates" do
      expect(config.currency_rates).not_to be_empty
    end

    it "has available currencies" do
      expect(config.available_currencies).to match_array(%w(EUR USD Bitcoin))
    end
  end

  context "User config" do

    before(:all) do
      @config = Monee::Config.instance
      @config.base_currency = 'INR'
      @config.currency_rates = { 'example' => 123 }
      @config.set_default_rate
    end

    it "set a base_currency" do
      expect(@config.base_currency).to eq('INR')
    end

    it "has a currency_rates" do
      expect(@config.currency_rates).not_to be_empty
    end

    it "has available currencies" do
      expect(@config.available_currencies).to match_array(%w(INR example))
    end

    it 'fetches the correct rate' do
      expect(@config.fetch_rate('example')).to eq(123)
    end

    it 'check if code exists' do
      expect(@config.exists?('example')).to be_truthy
    end

    it 'resets values' do
      @config.reset
      expect(@config.base_currency).to be_nil
      expect(@config.currency_rates).to be_nil
    end
  end
end
