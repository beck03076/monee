require 'singleton'
module Monee
  # inherits from config and this the null object for config with default values
  #
  # @see https://en.wikipedia.org/wiki/Null_Object_pattern
  class NoConfig < Config
    include Singleton

    # default base currecy
    DEFAULT_BASE_CURRENCY = 'EUR'.freeze
    # default currency_rates
    DEFAULT_CURRENCY_RATES = {
      'USD'     => 1.11,
      'Bitcoin' => 0.0047
    }

    # @return [String]
    def base_currency
      DEFAULT_BASE_CURRENCY
    end

    # @return [Hash]
    def currency_rates
      DEFAULT_CURRENCY_RATES
    end
  end
end
