require 'dancing_links_sudoku'

class Sudoku
  
  def solve_puzzle(puzzle)
    s = DancingLinksSudoku.new(puzzle)
    
    while(!(solution = s.solveit()).nil?) do
      9.times do |row|
        puts "#{solution.row(row).to_a.join(" ")}"
      end
    puts "-" * 18
    end
  end
  
  
end


sudoku = Sudoku.new

puzzle = Matrix.rows([
  [4, 0, 3, 0, 0, 8, 0, 0, 0],
  [9, 2, 0, 0, 0, 0, 1, 0, 6],
  [0, 0, 0, 0, 0, 6, 0, 0, 0],
  [5, 0, 6, 0, 2, 0, 0, 0, 0],
  [0, 4, 0, 3, 0, 1, 0, 2, 0],
  [0, 0, 0, 0, 7, 0, 9, 0, 8],
  [0, 0, 0, 7, 0, 0, 0, 0, 0],
  [3, 0, 5, 0, 0, 0, 0, 1, 2],
  [0, 0, 0, 1, 0, 0, 5, 0, 9]
])

sudoku.solve_puzzle(puzzle)