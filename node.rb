class Node
  attr_accessor :left, :right, :up, :down # Nodes
  attr_accessor :column                   # Column
  attr_reader   :row_number, :label       
  
  def label_or_null(node)
    node.nil? ? "NULL" : node.full_label
  end 
  
  def full_label
    "row #{row_number}, label #{label}"
  end

  def to_s
    <<-EOS
      Node:   #{full_label};
      Left:   #{label_or_null(left)};
      Right:  #{label_or_null(right)}; 
      Down:   #{label_or_null(down)};
      Up:     #{label_or_null(up)};
      Column: #{label_or_null(column)};
    EOS
  end
  
  def verify_row_and_label(row,label)
    @row_number == row and @label == label
  end
  
  # it creates a self-referential node
  # (creo un nodo che punta solo a se stesso)
  def initialize(row,label,column)
    @left, @right, @up, @down = [self]*4
    @column, @row_number, @label = column, row, label
  end
  
end