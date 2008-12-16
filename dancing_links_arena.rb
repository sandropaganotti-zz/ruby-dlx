class DancingLinksArena
  
  attr_reader :first_column
  attr_reader :solution, :solution_index 
  
  def initialize(labels, optional=[])
    
    columns = []
    # Generate and links all the ColumnsNode
    labels.each_with_index do |l,i|
      columns[i] = ColumnNode.new(l,optional[i])
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
    
    columns.each do |c|
      puts c.to_s if DEBUG
    end

    
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
        row_traveller = row_traveller.left
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
      @row_count = @row_count.to_i + 1
      prev  = nil
      first = nil
      
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
        
        prev.nil? ? first = node : prev.right = node
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
    next_column = node.column
    
    
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
    puts "solve 5" if DEBUG
    result = nil
    while (result.nil?)
      
      this_column = @traveller.column 
      #puts "solve 6  #{@traveller.to_s}" if DEBUG
      #puts "sono qui dentro #{@i = @i.to_i + 1}" if DEBUG
      
      # Check if traveller has completed one ring (visited all the columns)
      if ((this_column == @first_column) or (this_column == @traveller))    
      puts "#{@l = @l.to_i + 1}° giro" if DEBUG
      break if @l == 30
        
        puts "#{@solution_index} - #{@starting_count} #{@solution.collect{|e| e.class.to_s}.join(" ")}" if DEBUG
        if (this_column == @first_column) 
          result = Array.new(@solution_index)
          @solution_index.times do |i|
            result[i] = @solution[i].row_number - 1
          end
        end
        
        if (@solution_index == @starting_count)
          puts "ESCO DA QUAAA" if DEBUG
          puts "#{@traveller.to_s}"  if DEBUG
          return result 
        else
          @solution_index = @solution_index - 1
          @traveller = @solution[@solution_index]
          puts "TRAVELLER: " + @traveller.to_s + "\n==============" if DEBUG
          reinsert_row(@traveller)
          @traveller = @traveller.down
        end
        
      else  
        remove_row(@traveller)
        @solution[@solution_index] = @traveller
        @solution_index += 1
        @traveller = next_non_optional_column(@first_column).down
        
      end
    end
    
    return result
  end
  
  # Perform "Algorithm X" on this sparse boolean matrix
  def solve
    puts "solve 2" if DEBUG
    
    if (@traveller.nil?)
      puts "solve 3" if DEBUG
      @traveller      = next_non_optional_column(@first_column).down
      puts "trovato anche traveller #{@traveller.to_s}" if DEBUG
      @starting_count = @solution_index
      puts "solution index #{@solution_index}" if DEBUG
    end
    
    puts "traveller #{@traveller.to_s}" if DEBUG
    return solve_non_recurse
  end
  
  def remove_initial_solution_set(solutions)
    solutions.each do |row|
      remove_row(row)
      @solution[@solution_index] = row
      @solution_index = @solution_index + 1
    end
  end
end