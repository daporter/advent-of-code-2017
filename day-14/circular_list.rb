# Implements a circular list such that operations that would otherwise attempt
# to operate beyond the end of the list instead wrap around to the beginning
# of the list.
class CircularList
  attr_reader :elements
  attr_accessor :current_position
  attr_reader :current_skip_size

  # Returns a new CircularList of length 'length' with elements 0, 1, ...,
  # length-1
  def initialize(length)
    @elements = (0..(length - 1)).to_a
    @current_position = 0
    @current_skip_size = 0
  end

  # Reverses the order of 'count' elements, starting at the current position.
  def reverse_elements(count)
    list = if sublist_wraps?(count)
             reverse_elements_with_wrapping(count)
           else
             reverse_elements_without_wrapping(count)
           end
    advance_current_position(count)

    list
  end

  def sublist_wraps?(count)
    @elements.length < @current_position + count
  end

  # Reverses the order of the sublist such that it does not wrap. E.g.
  #
  # 0 1 (2 3 4) 5
  def reverse_elements_without_wrapping(count)
    prefix = @elements[0, @current_position]
    reversed_sublist = @elements[@current_position, count].reverse
    suffix = @elements[(@current_position + count)..-1]

    @elements = prefix + reversed_sublist + suffix
  end

  # Reverses the order of the sublist  such that it wraps. E.g.
  #
  #  0 1) 2 4 (4 5
  def reverse_elements_with_wrapping(count)
    sublist_end = (@current_position + count - 1) % @elements.length
    non_sublist = @elements[(sublist_end + 1)..(@current_position - 1)]

    rev_pref, rev_suf = reverse_and_wrap_sublist(@current_position, sublist_end)
    @elements = rev_suf + non_sublist + rev_pref
  end

  def reverse_and_wrap_sublist(sublist_beg, sublist_end)
    sublist_pref = @elements[sublist_beg..-1]
    sublist_suf = @elements[0..sublist_end]

    sublist_rev = (sublist_pref + sublist_suf).reverse

    pref_len = sublist_pref.length
    [sublist_rev.take(pref_len), sublist_rev.drop(pref_len)]
  end

  # Move the current position forward by 'count' plus the current skip size.
  def advance_current_position(count)
    @current_position = (@current_position + count + @current_skip_size) %
                        @elements.length
    @current_skip_size += 1
  end

  # Returns the first 'count' elements in the list.
  def take(count)
    @elements.take(count)
  end
end
