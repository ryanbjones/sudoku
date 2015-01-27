class Sudoku
  attr_reader :board
  COMPLETE_SET = ["1","2","3","4","5","6","7","8","9"]

  def initialize(board)
    @board = board_to_array(board)
  end

  def guess
    board.each_with_index do |row, row_i|
      row.each_with_index do |col, col_i|
        if blank?(col)
          p
          @board[row_i][col_i] = possibilities(row_i,col_i).first
          return
        end
      end
    end
  end

  def blank?(cell)
    cell == "-"
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

  def grid(row, col)
    sets = [[0,1,2],[3,4,5],[6,7,8]]
    row_set = sets.select {|set| set.include?(row)}[0]
    col_set = sets.select {|set| set.include?(col)}[0]
    row_set.map do |row|
      col_set.map do |col|
        @board[row][col]
      end
    end.flatten
  end

  def possibilities(row,col)
    used_numbers = get_row(row) + get_column(col) + get_grid(row, col) - ["-"]
    COMPLETE_SET  - used_numbers
  end

end