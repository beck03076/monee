module Monee
  class Money
    include Arithmetic
    include Conversion
    include Comparison

    attr_reader :cents, :currency_code

    class << self
      def conversion_rates(base_currency, currency_rates)
        Currency.configure do |config|
          config.base_currency = base_currency
          config.currency_rates = currency_rates
          config.set_default_rate
        end
      end
    end

    def klass
      self.class
    end

    def initialize(amount, currency_code)
      @amount = amount
      @cents = amount.to_cents
      @currency_code = currency_code
      validate_args!
      set_currency
    end

    def currency
      currency_code
    end

    def amount
      cents.to_amount
    end

    def inspect
      "#{format('%.2f', amount)} #{currency}"
    end

    private

    def validate_args!
      raise InvalidAmount unless @amount.is_a?(Numeric) && @amount >= 0
      raise InvalidCurrency unless @currency_code =~ /[A-Za-z]/
    end

    def set_currency
      @currency ||= Currency.new(code: currency_code)
    end
  end
end
