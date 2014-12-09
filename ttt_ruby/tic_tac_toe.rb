class Board
  
  attr_accessor :grid, :has_won, :transposed
  
  def initialize
    @grid = [[00, 01, 02], [10, 11, 12], [20, 21, 22]]
    @has_won = false
    @transposed = [[],[],[]]
  end
  
  def won?
    if check_row(@grid)
      puts "puts check_row"
      return true
    elsif check_row(check_transposed)
      puts "check_transposed check_row"
      # transposed_board = board.check_transpose
      # transposed_board.check_row
      return true
    elsif check_first_diagonal
      puts "Check_first_diagonal"
      return true
    elsif check_second_diagonal
      puts "Check_second_diagonal"
      return true
    else
      false
    end
  end
  
  def check_cols
    false
  end
  
  def win_rows?(row)
   row[0] == row[1] && row[1] == row[2]
  end
  
  def check_row(rows)
    has_won = false
    rows.each_with_index do |row, ind1|
      has_won = true if win_rows?(row)
    end
    has_won
  end
  
  def check_first_diagonal
    @grid[0][0] == @grid[1][1] && @grid[1][1] == @grid[2][2] 
  end
  
  def check_second_diagonal
    @grid[0][2] == @grid[1][1] && @grid[1][1] == @grid[2][0] 
  end
  
  def check_transposed
    @grid.each_with_index do |num1, ind1|
      @grid[ind1].each_with_index do |num2, ind2|
        @transposed[ind1][ind2] = @grid[ind2][ind1]
      end
    end
    @transposed 
  end
end

class Game 
    
  def initialize
    @game_board = Board.new
    @player_1 = HumanPlayer.new
    @player_2 = ComputerPlayer.new
  end
  
  def play
    draw_count = 0
    puts "entered play"
    current_player = @player_1
    #check for draw  
    until @game_board.won?
      print_board
      current_player.move(@game_board)
      draw_count += 1
      if draw_count > 7
        puts "No Winner"
        break
      end
      current_player = swap_player(current_player)
    end
    puts "Winner is #{swap_player(current_player)}"
  end
  
  def draw?
    
  end
  
  
  def print_board
    p @game_board.grid[0]
    p @game_board.grid[1]
    p @game_board.grid[2]
  end
  
  def swap_player(player)
    puts "entered swap_players"
    if player == @player_1
      player = @player_2
    else
      player = @player_1
    end
    player
  end
end

class ParentPlayer
  def initialize
    @row
    @col
  end
  
  def move(board)
    puts "Select a spot"
    spot = gets.chomp
    @row = spot[0].to_i
    @col = spot[1].to_i  
    
  end
end

class HumanPlayer < ParentPlayer
  def move(board)
    super
    puts "player move"
    if board.grid[@row][@col].is_a?(Integer)
      board.grid[@row][@col] = 'X'
    else
      puts "Bad Move"
      self.move 
    end
  end
end

class ComputerPlayer < ParentPlayer

  def move(board)
    puts "computer move"
    comp_moved = false
    until comp_moved
      row = rand(2)
      col = rand(2)
      if board.grid[row][col].is_a?(Integer)
        board.grid[row][col] = 'O'
        comp_moved = true
      end
    end 
  end
end

test = Game.new
test.play

