require 'matrix'
require '../../dlx'

class DancingLinksQueens
  
  def handle_solution(row_index)
    return nil if row_index.nil?
    
    solution = Array.new
    8.times do |i|
      value = row_index[i]
      column= value % 8
      value = value / 8
      row   = value % 8
      solution[row] ||= Array.new
      solution[row][column] = 1
    end
   
    8.times do |r|
     8.times do |c|
       solution[r][c] = solution[r][c].nil? ? 0 : 1
     end
    end
   
   return Matrix.rows(solution)
  end
  
  def initialize()
    labels = (1..42).to_a
    @dla = DancingLinksArena.new(labels,[false]*16 + [true]*26)
    given_list = []
    row_data = []
    
    8.times do |x|
      8.times do |y|
        row_data[0] = x+1
        row_data[1] = y+1 + 8
        row_data <<  ((y+1) - (x+1)) + 7  + 16  unless [-7,7].include?(y - x) 
        row_data <<  (x + y + 2) - 2 + 13 + 16  unless [0,14].include?(x + y)
        new_row = @dla.add_initial_row(row_data)
        row_data = []
      end
    end
  end
  
  def solveit
    handle_solution(@dla.solve)
  end
  
end