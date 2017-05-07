module Monee
  # helper module to fetch the right config instance
  module Configurable
    # yields the Config.instance if a block is called
    #
    # Currency.configure do |conf|
    # conf.variable = value
    # end
    def configure
      yield(actual_config) if block_given?
    end

    # checks if config values are nil and returns no_config or config
    #
    # @return [Config, NoConfig]
    def config
      (null_config? ? NoConfig.instance : actual_config)
    end

    # checks if the config values are nil
    def null_config?
      actual_config.base_currency.nil? || actual_config.currency_rates.nil?
    end

    # simple way to access the config singleton instance
    def actual_config
      Config.instance
    end
  end
end
