class Sudoku
  attr_reader :board

  def initialize(board)
    @board = board_to_array(board)
  end

  def board_to_array(board)
    first_layer = board.split("")
    Array.new (9) { first_layer.shift(9) }
  end

  def row(row)
    @board[row]
  end

  def column(col)
    @board.transpose[col]
  end
end