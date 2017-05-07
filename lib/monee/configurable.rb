module Monee
  module Configurable
    def configure
      yield(actual_config) if block_given?
    end

    def config
      (null_config? ? NoConfig.instance : actual_config)
    end

    def null_config?
      actual_config.base_currency.nil? || actual_config.currency_rates.nil?
    end

    def actual_config
      Config.instance
    end
  end
end
