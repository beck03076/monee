module Monee
  # class to manage currency code and rate, also the exchange
  class Currency
    # class methods to access the config values
    extend Configurable

    # error message to raise with for uninitialized currencies
    NO_CURRENCY = 'This currency\'s conversion rate is not configured,
    please use Monee::Money.conversion_rates'.freeze

    # error message to raise for empty string as currency
    EMPTY_CURRENCY = 'Currency cannot to empty!'.freeze

    attr_reader :code, :rate

    # creates a currency object with code
    #
    # @param options [Hash] code: 'USD' is one example
    # @return [Currency]
    def initialize(**options)
      options = options.compact
      @code = options[:code]
      @rate = config.fetch_rate(@code) if valid_currency?
    end

    # exchanges the current currency to to_currency with cents and rate
    #
    # @params to_currency [String] target currency to be converted to
    # @params cents [Numeric] number of cents to be converted
    # @raise [UndefinedCurrency] if to_currency is not in Config
    # @return [Numeric] number of cents converted
    def exchange(to_currency, cents)
      raise UndefinedCurrency, NO_CURRENCY unless config.exists?(to_currency)
      (cents / rate) * config.fetch_rate(to_currency)
    end

    # @return [Config, NoConfig]
    def config
      self.class.config
    end

    private

    # validation for currency object
    #
    # @raise [EmptyCurrency] if currency is empty string
    # @raise [UndefinedCurrency] if to_currency is not in Config
    def valid_currency?
      raise EmptyCurrency, EMPTY_CURRENCY if code.empty?
      raise UndefinedCurrency, NO_CURRENCY unless config.exists?(code)
      true
    end
  end
end
