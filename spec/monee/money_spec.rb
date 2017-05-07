require "spec_helper"

RSpec.describe Monee::Money do

  before(:all) do
    Monee::Config.instance.reset
  end

  context "interfaces of the class" do
    let(:money) { Monee::Money.new(4, 'EUR') }

    it 'responds_to all the interfaces' do
      expect(money.klass).to eq(Monee::Money)
      expect(money.currency).to eq('EUR')
      expect(money.amount).to eq(4)
      expect(money.cents).to eq(400)
      expect(money.inspect).to eq('4.00 EUR')
    end
  end

  context "invalid amount and currency" do
    it 'raises error for invalid amount' do
      expect { Monee::Money.new(-9, 'USD') }.to raise_error InvalidAmount
    end
    it 'raises error for invalid currency' do
      expect { Monee::Money.new(9, '%^&*(') }.to raise_error InvalidCurrency
    end
    it 'raises error for empty currency' do
      expect { Monee::Money.new(9, '') }.to raise_error InvalidCurrency
    end
  end

  let(:fifty_eur) { Monee::Money.new(50, 'EUR') }

  context "expected outputs from user" do
    it 'get amount, currency and inspect' do
      expect(fifty_eur.amount).to eq(50)
      expect(fifty_eur.currency).to eq('EUR')
      expect(fifty_eur.inspect).to eq('50.00 EUR')
    end

    it "convert to different currency" do
      expect(fifty_eur.convert_to('USD').inspect).to eq('55.50 USD')
    end
  end

  let(:twenty_dollars) { Monee::Money.new(20, 'USD') }

  context "perform operation in different currencies" do
    it 'adds euros and dollars' do
      expect((fifty_eur + twenty_dollars).inspect).to eq('68.02 EUR')
    end
    it 'subtracts euros and dollars' do
      expect((fifty_eur - twenty_dollars).inspect).to eq('31.98 EUR')
    end
    it 'multiplies euros and dollars' do
      expect((fifty_eur * twenty_dollars).inspect).to eq('90090.09 EUR')
    end
    it 'divides euros and dollars' do
      expect((fifty_eur / twenty_dollars).inspect).to eq('0.03 EUR')
    end
  end

  context "perform operation between number and currencies" do
    it 'adds 2 to euros' do
      expect((fifty_eur + 2).inspect).to eq('52.00 EUR')
    end
    it 'subtracts 2 from euros' do
      expect((fifty_eur - 2).inspect).to eq('48.00 EUR')
    end
    it 'multiplies 2 to euros' do
      expect((fifty_eur * 2).inspect).to eq('100.00 EUR')
    end
    it 'divides 2 from euros' do
      expect((fifty_eur / 2).inspect).to eq('25.00 EUR')
    end
  end

  context "perform coerced operation between number and currencies" do
    it 'adds 2 to euros' do
      expect((2 + fifty_eur).inspect).to eq('52.00 EUR')
    end
    it 'subtracts 2 from euros' do
      expect((2 - fifty_eur).inspect).to eq('48.00 EUR')
    end
    it 'multiplies 2 to euros' do
      expect((2 * fifty_eur).inspect).to eq('100.00 EUR')
    end
    it 'divides 2 from euros' do
      expect((2 / fifty_eur).inspect).to eq('25.00 EUR')
    end
  end

  context "perform comparisons between currencies" do
    it 'compares object with new object' do
      expect(twenty_dollars == Monee::Money.new(20, 'USD')).to be_truthy
      expect(twenty_dollars == Monee::Money.new(30, 'USD')).to be_falsy
    end

    it 'converts and compares currencies' do
      fifty_eur_in_usd = fifty_eur.convert_to('USD')
      expect(fifty_eur_in_usd == fifty_eur).to be_truthy
    end

    it 'compares currencies with greater than' do
      expect(twenty_dollars > Monee::Money.new(5, 'USD')).to be_truthy
      expect(twenty_dollars < fifty_eur).to be_truthy
    end
  end
end
