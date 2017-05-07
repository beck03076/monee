module Monee
  class Currency
    extend Configurable

    NO_CURRENCY = 'This currency\'s conversion rate is not configured,
    please use Monee::Money.conversion_rates'.freeze

    EMPTY_CURRENCY = 'Currency cannot to empty!'.freeze

    attr_reader :code, :rate

    def initialize(**options)
      options = options.compact
      @code = options[:code]
      @rate = config.fetch_rate(@code) if valid_currency?
    end

    def exchange(to_currency, cents)
      raise UndefinedCurrency, NO_CURRENCY unless config.exists?(to_currency)
      (cents / rate) * config.fetch_rate(to_currency)
    end

    def config
      self.class.config
    end

    private

    def valid_currency?
      raise EmptyCurrency, EMPTY_CURRENCY if code.empty?
      raise UndefinedCurrency, NO_CURRENCY unless config.exists?(code)
      true
    end
  end
end
