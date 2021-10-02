class MergeSort
  # @param [Array] list
  def sort(list)
    if list.length <= 1
      return list
    end

    half = list.length / 2

    left = sort list[0...half]
    right = sort list[half...]
    merge(left, right)
  end

  private

  # @param [Array] left
  # @param [Array] right
  def merge(left, right)
    merged_list = []

    while !left.empty? && !right.empty?
      merged_list.push(left[0] < right[0] ? left.shift : right.shift)
    end

    # Merge remaining
    left.each { |i| merged_list.push i }
    right.each { |i| merged_list.push i }
    merged_list
  end
end