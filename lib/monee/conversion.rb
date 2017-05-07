module Monee
  # modularizing all the conversion related logic under one module
  module Conversion
    # converts to a target currency
    #
    # @param to_currency [String]
    # @return [Money]
    def convert_to(to_currency)
      amount = convert_to_cents(to_currency).to_amount
      klass.new(amount, to_currency)
    end

    # convert to cents for a target currency
    #
    # @param to_currency [String]
    # @return [Numeric]
    def convert_to_cents(to_currency)
      if to_currency == currency
        cents
      else
        @currency.exchange(to_currency, cents)
      end
    end
  end
end
