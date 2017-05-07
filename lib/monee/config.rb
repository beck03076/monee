require 'singleton'
module Monee
  # Singleton class that can be initiated only once to
  # hold the configuration values
  # @see https://ruby-doc.org/stdlib-2.2.2/libdoc/singleton/rdoc/Singleton.html
  class Config
    include Singleton

    # this is default rate, against this value other
    # currency rates are calculated
    DEFAULT_RATE = 1

    attr_accessor :base_currency, :currency_rates

    # to reset the configuration values
    # @return [void]
    def reset
      self.base_currency = nil
      self.currency_rates = nil
    end

    # fetches the rate of a currency by code of the currency
    #
    # @param code [String] code of the currency
    # @return [Numeric]
    def fetch_rate(code)
      currency_rates[code]
    end

    # checks if the code exists in the config
    #
    # @param code [String] code of the currency
    # @return [Boolean]
    def exists?(code)
      available_currencies.include?(code)
    end

    # retrieves all the currencies configured including the base
    #
    # @return [Array]
    def available_currencies
      set_default_rate
      currency_rates.keys
    end

    # sets the default rate to the base currency as 1
    #
    # @return [void]
    def set_default_rate
      currency_rates[base_currency] = DEFAULT_RATE
    end
  end
end
