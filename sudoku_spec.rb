require_relative "sudoku"

describe Sudoku do
  let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--
")}
  it 'loads a sudoku board as a nested array' do
    expect(game.board).to eq([
      ["1", "-", "5", "8", "-", "2", "-", "-", "-"],
      ["-", "9", "-", "-", "7", "6", "4", "-", "5"],
      ["2", "-", "-", "4", "-", "-", "8", "1", "9"],
      ["-", "1", "9", "-", "-", "7", "3", "-", "6"],
      ["7", "6", "2", "-", "8", "3", "-", "9", "-"],
      ["-", "-", "-", "-", "6", "1", "-", "5", "-"],
      ["-", "-", "7", "6", "-", "-", "-", "3", "-"],
      ["4", "3", "-", "-", "2", "-", "5", "-", "1"],
      ["6", "-", "-", "3", "-", "8", "9", "-", "-"]
    ])
  end

  it '#row returns a row selected' do
    expect(game.get_row(2)).to eq(["2", "-", "-", "4", "-", "-", "8", "1", "9"])
  end

  it '#column returns a selected column' do
    expect(game.get_column(3)).to eq(["8","-","4","-","-","-","6","-","3"])
  end

  it '#grid returns a selected grid' do
    expect(game.get_grid(4,5)).to eq(["-", "-", "7","-", "8", "3","-", "6", "1"])
  end

  it 'returns a list of possible numbers for a given cell' do
    expect(game.possibilities(8,2)).to eq(["1"])
  end

  it 'places a guess in an empty cell' do
    game.guess
    expect(game.board).to eq([
      ["1", "4", "5", "8", "-", "2", "-", "-", "-"],
      ["-", "9", "-", "-", "7", "6", "4", "-", "5"],
      ["2", "-", "-", "4", "-", "-", "8", "1", "9"],
      ["-", "1", "9", "-", "-", "7", "3", "-", "6"],
      ["7", "6", "2", "-", "8", "3", "-", "9", "-"],
      ["-", "-", "-", "-", "6", "1", "-", "5", "-"],
      ["-", "-", "7", "6", "-", "-", "-", "3", "-"],
      ["4", "3", "-", "-", "2", "-", "5", "-", "1"],
      ["6", "-", "-", "3", "-", "8", "9", "-", "-"]
    ])
  end

  it 'returns false if the board is invalid' do
    game.board[0][1] = "5"
    expect(game.valid_board?).to eq(false)
  end

  it 'returns false if a row is invalid' do
    game.board[0][1] = "5"
    expect(game.valid_row?(0)).to eq(false)
  end

  it 'returns false if a column is invalid' do
    game.board[0][1] = "9"
    expect(game.valid_col?(1)).to eq(false)
  end

  it 'returns false if a grid is invalid' do
    game.board[0][1] = "2"
    expect(game.valid_grid?(0,0)).to eq(false)
  end
end