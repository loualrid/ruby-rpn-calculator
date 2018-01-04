# frozen_string_literal: true

class Array
  def same_values?
    uniq.length == 1
  end
end
