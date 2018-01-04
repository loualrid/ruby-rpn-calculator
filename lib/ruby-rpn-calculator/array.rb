class Array
  def same_values?
    self.uniq.length == 1
  end
end
