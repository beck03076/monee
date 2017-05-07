# A general monee exception
class Error < StandardError; end
# Raised when currency is undefined
class UndefinedCurrency < Error; end
# Raised when currency is empty
class EmptyCurrency < Error; end
# Raised when currency is invalid
class InvalidCurrency < Error; end
# Raised when amount is invalid
class InvalidAmount < Error; end
# Raised when operand is invalid
class InvalidOperand < Error; end
