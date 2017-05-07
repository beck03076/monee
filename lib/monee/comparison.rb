module Monee
  module Comparison
    include Comparable

    def <=>(other)
      if currency == other.currency
        cents <=> other.cents
      else
        cents <=> other.convert_to_cents(currency)
      end
    end
  end
end
