require 'node'

class ColumnNode < Node
  # size:     Number of rows which have a "1" in this column
  # optional: An optional column represent a constraint that does not 
  #           have to be satisfied but can only be satisfied once. 
  #           columns that are not optional must be satisfied once and only
  #           once 
  attr_reader :size, :optional  
  
  # Add a node (a row containing '1' in this column) to the end of this column
  def add_at_end(node)
    @end      = @up
    node.up   = @end
    node.down = self
    @end.down = node
    @up       = node
    @size     = @size.to_i + 1
  end
  
  def initialize(label, optional)
    super(0,label,nil)
    @column, @optional, size = self, optional, 0
  end
  
  def to_s
    <<-EOS
      #{super}
      Size:   #{size};  
    EOS
  end
  
  def optional?
    optional ? true : false
  end
  
  def increment_size
    @size = @size.to_i + 1
  end
  
  def decrement_size
    @size = @size.to_i - 1
  end
end