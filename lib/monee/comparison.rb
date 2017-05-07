module Monee
  # modularizing the comparison of money objects method in a separate module
  module Comparison
    include Comparable

    # this is the spaceship operator overriding, this will take care of >, <, ==
    #
    # @params other [Money, Numeric]
    # @return [Boolean]
    def <=>(other)
      if currency == other.currency
        cents <=> other.cents
      else
        cents <=> other.convert_to_cents(currency)
      end
    end
  end
end
