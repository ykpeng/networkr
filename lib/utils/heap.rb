class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @index_map {}
    @prc = prc || Proc.new { |a, b| a <=> b }
  end

  def count
    @store.length
  end

  def pop
    return nil if count == 0

    self.class.swap!(@store, @index_map, 0, count - 1)

    val = @store.pop
    @index_map.delete(val)

    unless count == 0
      self.class.heapify_down(@store, @index_map, 0, &prc)
    end

    val
  end

  def peek
    return nil if count == 0
    @store.first
  end

  def push(val)
    @store << val
    @index_map[val] = count - 1
    self.class.heapify_up(@store, @index_map, count - 1, &prc)
  end

  def reduce!(val)
    index = @index_map[val]
    self.class.heapify_up(@store, @index_map, index, &prc)
  end

  protected
  attr_accessor :prc, :store, :index_map

  public
  def self.swap!(array, index_map, i1, i2)
    array[i1], array[i2] = array[i2], array[i1]
    index_map[parent_val], index_map[child_val] = child_idx, parent_idx
  end

  def self.child_indices(len, parent_index)
    [2 * parent_index + 1, 2 * parent_index + 2].select { |idx| idx < len }
  end

  def self.parent_index(child_index)
    if child_index == 0
      return nil
    else
      (child_index - 1) / 2
    end
  end

  def self.heapify_down(array, index_map, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    while parent_idx <= parent_index(len - 1)
      children = child_indices(len, parent_idx)

      if children.length == 1
        smallest_child_idx = children[0]
      else
        child1_idx, child2_idx = children[0], children[1]

        if prc.call(array[child1_idx], array[child2_idx]) <= 0
          smallest_child_idx = child1_idx
        else
          smallest_child_idx = child2_idx
        end
      end

      if prc.call(array[parent_idx], array[smallest_child_idx]) > 0
        swap!(array, index_map, parent_idx, smallest_child_idx)
        parent_idx = smallest_child_idx
      else
        break
      end

    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    while child_idx > 0
      parent_idx = parent_index(child_idx)

      if prc.call(array[parent_idx], array[child_idx]) > 0
        swap!(array, index_map, parent_idx, child_idx)
        child_idx = parent_idx
      else
        break
      end

    end

    array
  end
end
