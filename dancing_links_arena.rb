class DancingLinksArena
  
  attr_reader :first_column
  attr_reader :solution, :solution_index 
  
  def initialize(labels, optional=[])
    
    # Generate and links all the ColumnsNode
    labels.each_with_index do |l,i|
      (columns ||= [])[i] = ColumnNode.new(l,optional[i])
      columns[i].right = nil
      if i > 0
        columns[i].left    = columns[i-1]
        columns[i-1].right = columns[i]
      end
    end
    
    # Generate the first ColumnNode
    @first_column       = ColumnNode.new(0,false)
    columns.first.left  = @first_column
    @first_column.right = columns.first
    columns.last.right  = @first_column
    @first_column.left  = columns.last 
    
    # Generate a 'solution' Node array
    @solution           = []
    @solution_index     = 0
  end
  
  # Here we mean columns[0], not @first_column
  def get_first_column 
    @first_column.right 
  end
  
  def remove_column(column_head)
    scanner = column_head.down
    
    # Remove all the elements inside this column
    while (scanner != column_head) do
      row_traveller = scanner.right
      
      # Eliminate a single element
      while (row_traveller != scanner) do
        row_traveller.up.down = row_traveller.down
        row_traveller.down.up = row_traveller.up
        row_traveller.column.decrement_size
        row_traveller = row_traveller.right
      end
      
      scanner = scanner.down
    end
    
    # Now remove the column
    column_head.left.right = column_head.right
    column_head.right.left = column_head.left  
  end
  
  
  def reinsert_column(column_node)
    scanner = column_node.up
    
    # Iterate through the rows
    while (scanner != column_node) do
      row_traveller = scanner.left
      
      while (row_traveller != scanner ) do
        row_traveller.up.down = row_traveller
        row_traveller.down.up = row_traveller
        row_traveller.column.increment_size
        row_traveller = row_traveller.right
      end
      
      scanner = scanner.up
    end
  
    # Now put the column back in the column-header list
    column_node.left.right = column_node
    column_node.right.left = column_node
  end
  
  def remove_row(row_head)
    scanner = row_head
    
    begin 
      temp = scanner.right
      remove_column(scanner.column)
    end while ((scanner = temp) != row_head) 
  end
  
  def reinsert_row(row_head)
    scanner = row_head
    
    begin 
      scanner = scanner.left
      reinsert_column scanner.column 
    end while (scanner != row_head )
  end
  
  def add_initial_row(labels, length=labels.to_a.size)
    if length != 0
      @row_count = @row_count + 1
      
      length.times do |i|
        searcher = @first_column 
        
        begin 
          if searcher.label == labels[i]
            the_column = searcher
            break
          end
        end while ((searcher = searcher.right) != @first_column) 
        
        raise "Couldn't find a column labelled #{labels[i]}" if the_column.nil?
        node = Node.new(@row_count, labels[i], the_column)
        the_column.add_at_end(node)
        node.left  = prev
        node.right = nil
        
        prev.nil ? first = node : prev.right = node
        prev = node
      end
      
      # 'prev' now points to the last node. 'first' point 
      # to the first. Complete the circular list
      first.left = prev
      prev.right = first      
    end
    
    return first
  end
  
  # Return the next non-optional column
  def next_non_optional_column(node)
    next_column = node.get_column
    
    # Move to the right until the first non-optional column is found
    begin
      next_column = next_column.right.column
    end while(next_column.size == 0 and next_column.optional?)
    
    return next_column
  end
  
  # The 'traveller' move (depth-first) from column to column. After the 
  # traveller has moved through each columns to the right of the current
  # column, it moves down one row in the current column and then moves to
  # the right
  def solve_non_recurse
    while (result.nil?)
      this_column = @traveller.column 
      
      # Check if traveller has completed one ring (visited all the columns)
      if ((this_column == @first_column) or (this_column == @traveller))    
        
        if (this_column == @firts_column) 
          result = []
          @solution_index.times do |i|
            result[i] = @solution[i].row_number - 1
          end
        end
        
        if (@solution_index == @starting_count)
          return result 
        else
          @traveller = @solution[(@solution_index -= 1)]
          reinsert_row(@traveller)
          @traveller = @traveller.down
        end
        
      else  
        remove_row(@traveller)
        @solution[(@solution_index += 1)] = @traveller
        @traveller = next_non_optional_column(@first_column).down
        
      end
    end
    
    return result
  end
  
  # Perform "Algorithm X" on this sparse boolean matrix
  def solve
    if (@traveller.nil?)
      @traveller      = next_non_optional_column(@first_column).down
      @starting_count = @solution_index
    end
    
    return solve_non_recurse
  end
  
  def remove_initial_solution_set(solutions)
    solutions.each do |row|
      remove_row(row)
      @solution[(@solution_index += 1)] = row
    end
  end
end