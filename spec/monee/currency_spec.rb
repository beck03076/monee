require "spec_helper"

RSpec.describe Monee::Currency do

  before(:all) do
    Monee::Config.instance.reset
  end

  context "Default Config" do
    let(:currency) { Monee::Currency.new(code: 'USD') }

    it 'returns true for valid_currency?' do
      expect(currency.send(:valid_currency?)).to be_truthy
    end

    it 'has config defined' do
      expect(currency.config).to be_kind_of(Monee::Config)
      expect(currency.config.base_currency).to_not be_empty
      expect(currency.config.currency_rates).to_not be_empty
    end

    it 'exchanges money' do
      result = currency.exchange('USD', 5000)
      expect(result).to eq(5000)
    end

  end

  context "User Override Config" do

    before(:all) do
      Monee::Money.conversion_rates('INR',
                                    { 'Bitcoin' => 1.2,
                                      'STK' => 0.65 })

    end
    let(:undefined_currency) { Monee::Currency.new(code: 'USD') }
    let(:empty_currency) { Monee::Currency.new(code: '') }
    let(:currency) { Monee::Currency.new(code: 'Bitcoin') }

    it 'raises error for undefined' do
      expect { undefined_currency }.to raise_error(UndefinedCurrency)
    end

    it 'raises error for empty' do
      expect { empty_currency }.to raise_error(EmptyCurrency)
    end

    it 'has config defined' do
      expect(currency.config).to be_kind_of(Monee::Config)
      expect(currency.config.base_currency).to_not be_empty
      expect(currency.config.currency_rates).to_not be_empty
      expect(currency.config.available_currencies).to match_array(%w(INR Bitcoin STK))
    end

    it 'raises error if tried to exchange money with undefined currency' do
      expect { currency.exchange('USD', 5000) }.to raise_error(UndefinedCurrency)
    end

    it 'exchanges money' do
      result = currency.exchange('STK', 1)
      expect(result).to eq(0.5416666666666667)
    end

  end

end
