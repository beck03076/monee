require 'singleton'
module Monee
  class NoConfig < Config
    include Singleton

    DEFAULT_BASE_CURRENCY = 'EUR'.freeze
    DEFAULT_CURRENCY_RATES = {
      'USD'     => 1.11,
      'Bitcoin' => 0.0047
    }

    def base_currency
      DEFAULT_BASE_CURRENCY
    end

    def currency_rates
      DEFAULT_CURRENCY_RATES
    end
  end
end
