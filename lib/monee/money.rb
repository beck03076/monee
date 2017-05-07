# This is main module Monee for the entire project's namespace
module Monee
  # class to manipulate currencies as required
  class Money
    include Arithmetic
    include Conversion
    include Comparison

    attr_reader :cents, :currency_code

    class << self
      # Configures the config singleton class with default values
      #
      # @param base_currency [String]
      # @param currency_rates [Hash]
      # @return [void]
      def conversion_rates(base_currency, currency_rates)
        Currency.configure do |config|
          config.base_currency = base_currency
          config.currency_rates = currency_rates
          config.set_default_rate
        end
      end
    end
    # Initializes a money object
    #
    # @param amount [Numeric]
    # @param currency_code [String]
    # @return [Money]
    def initialize(amount, currency_code)
      @amount = amount
      @cents = amount.to_cents
      @currency_code = currency_code
      validate_args!
      set_currency
    end

    # @return [Money] method to access this class
    def klass
      self.class
    end

    # @return [String] the currency_code of the current object
    def currency
      currency_code
    end

    # @return [Numeric] passed amount of the object
    def amount
      cents.to_amount
    end

    # @return [String] formatted string of money
    def inspect
      "#{format('%.2f', amount)} #{currency}"
    end

    private

    # Validation of money arguments
    #
    # @raise [InvalidAmount] if amount is negative or not a number
    # @raise [InvalidCurrency] if currency_code is not alphabets
    def validate_args!
      raise InvalidAmount unless @amount.is_a?(Numeric) && @amount >= 0
      raise InvalidCurrency unless @currency_code =~ /[A-Za-z]/
    end

    # Sets the currency object in currency instance variable
    def set_currency
      @currency ||= Currency.new(code: currency_code)
    end
  end
end
