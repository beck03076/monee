# opening the numberic standard class to add 2 methods
class Numeric
  # multiply by 100
  def to_cents
    self * 100
  end

  # divide by 100
  def to_amount
    self / 100
  end
end
