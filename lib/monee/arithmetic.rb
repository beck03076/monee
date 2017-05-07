module Monee
  module Arithmetic
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

    def choose_operand(operator, operand)
      if %i[+ -].include?(operator)
        operand.to_cents
      elsif %i[* /].include?(operator)
        operand
      end
    end

    def coerce(other)
      return self, other
    end
  end
end
