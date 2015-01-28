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

  def solved?
    !@board.flatten.include?("-")
  end

  def valid_board?
    0.upto(8) do |i|
      return false unless valid_row?(i)
      return false unless valid_col?(i)
    end
    0.upto(2) do |r|
      0.upto(2) do |c|
        return false unless valid_grid?(r,c*3)
      end
    end
    true
  end

  def valid_row?(i)
    get_row(i).uniq - ["-"] == get_row(i) - ["-"]
  end

  def valid_col?(i)
    get_column(i).uniq - ["-"] == get_column(i) - ["-"]
  end

  def valid_grid?(r,c)
    get_grid(r,c).uniq - ["-"] == get_grid(r,c) - ["-"]
  end

  def blank?(cell)
    cell == "-"
  end

  def board_to_array(board)
    single_array = board.split("")
    Array.new (9) { single_array.shift(9) }
  end

  def get_row(row)
    board[row]
  end

  def get_column(col)
    board.transpose[col]
  end

  def get_grid(row, col)
    sets = [[0,1,2],[3,4,5],[6,7,8]]
    row_set = sets.select {|set| set.include?(row)}.flatten
    col_set = sets.select {|set| set.include?(col)}.flatten
    row_set.map do |row|
      col_set.map do |col|
        board[row][col]
      end
    end.flatten
  end

  def possibilities(row,col)
    used_numbers = get_row(row) + get_column(col) + get_grid(row, col) - ["-"]
    COMPLETE_SET  - used_numbers
  end

end