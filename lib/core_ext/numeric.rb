# opening the numberic standard class to add another method
class Numeric
  def to_cents
    self * 100
  end

  def to_amount
    self / 100
  end
end
