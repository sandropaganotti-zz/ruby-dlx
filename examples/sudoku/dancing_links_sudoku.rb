require 'matrix'
require '../../dlx'

class DancingLinksSudoku
  
  def handle_solution(row_index)
    return nil if row_index.nil?
    
    solution = Array.new
    81.times do |i|
      value = row_index[i]
      digit = value % 9
      value = value / 9
      column= value % 9
      value = value / 9
      row   = value % 9
      
      solution[row] ||= Array.new
      solution[row][column] = digit + 1
    end
    
    return Matrix.rows(solution)
  end
  
  def initialize(puzzle)
    labels = (1..324).to_a
    @dla = DancingLinksArena.new(labels)
    given_list = []
    row_data = []
    
    9.times do |row|
      9.times do |column|
        9.times do |digit|
          is_given    = (puzzle[row,column] == digit + 1)
          row_data[0] = 1 + (row * 9 + column)
          row_data[1] = 1 + 81 + (row * 9 + digit)
          row_data[2] = 1 + 81 + 81 + (column * 9 + digit)
          box_row     = row / 3
          box_col     = column / 3
          row_data[3] = 1 + 81 + 81 + 81 + ((box_row * 3 + box_col) * 9 + digit)
          new_row = @dla.add_initial_row(row_data)
          
          given_list.unshift new_row if is_given 
             
        end
      end
    end
    
    @dla.remove_initial_solution_set(given_list)
  end
  
  def solveit
    handle_solution(@dla.solve)
  end
  
end