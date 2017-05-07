module Monee
  # modularizing the arithmetic related methods in a separate module for money
  module Arithmetic
    # metaprogramming way of defining methods
    #
    # overloads the operators with 2 operands
    # adds amount/cents if number
    # converts to the currency and calculates if money object
    # @return [Money]
    %i[+ - * /].each do |operator|
      define_method(operator) do |operand|
        result_cents = case operand
                       when ::Numeric
                         cents.send(operator,
                                    choose_operand(operator, operand))
                       when klass
                         cents.send(operator,
                                    operand.convert_to_cents(currency))
                       else
                         raise InvalidOperand
                       end
        amount = result_cents.to_amount
        klass.new(amount, currency)
      end
    end

    # convert to cents if add or subtract
    # dont convert to cents if multiply or divide
    #
    # @params operator [+, -, *, /]
    # @return [Numeric]
    def choose_operand(operator, operand)
      if %i[+ -].include?(operator)
        operand.to_cents
      elsif %i[* /].include?(operator)
        operand
      end
    end

    # this method is to support the order of the operation
    # 2 * Monee::Money.new(50, 'EUR')
    def coerce(other)
      return self, other
    end
  end
end
