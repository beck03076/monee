module Monee
  module Conversion
    def convert_to(to_currency)
      amount = convert_to_cents(to_currency).to_amount
      klass.new(amount, to_currency)
    end

    def convert_to_cents(to_currency)
      if to_currency == currency
        cents
      else
        @currency.exchange(to_currency, cents)
      end
    end
  end
end
