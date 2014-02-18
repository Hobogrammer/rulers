class Array
  def sum(start = 0)
    inject(start, &:+)
  end

  def multiply(start=0)
    inject(start, &:*)
  end

  def divide(start=0)
    inject(start, &:/)
  end
end
