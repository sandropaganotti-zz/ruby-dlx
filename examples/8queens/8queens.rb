require 'dancing_links_queens'

class Queens
  
  def solve_puzzle()
    s = DancingLinksQueens.new()
    
    while(!(solution = s.solveit()).nil?) do
      8.times do |row|
        puts "#{solution.row(row).to_a.join(" ")}"
      end
    puts "-" * 18
    end
  end
  
  
end


Queens.new.solve_puzzle