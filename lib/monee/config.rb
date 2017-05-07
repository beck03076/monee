require 'singleton'
module Monee
  class Config
    include Singleton

    DEFAULT_RATE = 1

    attr_accessor :base_currency, :currency_rates

    def reset
      self.base_currency = nil
      self.currency_rates = nil
    end

    def fetch_rate(code)
      currency_rates[code]
    end

    def exists?(code)
      available_currencies.include?(code)
    end

    def available_currencies
      set_default_rate
      currency_rates.keys
    end

    def set_default_rate
      currency_rates[base_currency] = DEFAULT_RATE
    end
  end
end
