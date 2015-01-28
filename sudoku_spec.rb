require_relative "sudoku"

describe Sudoku do
  let(:game) {Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--
")}
  let(:blank_game) { Sudoku.new("---------------------------------------------------------------------------------")}

  let(:hard_game) {Sudoku.new("-2-5----48-5--------48-9-2------5-73-9-----6-25-9------3-6-18--------4-71----4-9-")}
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

  # it 'places a guess in an empty cell' do
  #   game.guess
  #   expect(game.board).to eq([
  #     ["1", "4", "5", "8", "-", "2", "-", "-", "-"],
  #     ["-", "9", "-", "-", "7", "6", "4", "-", "5"],
  #     ["2", "-", "-", "4", "-", "-", "8", "1", "9"],
  #     ["-", "1", "9", "-", "-", "7", "3", "-", "6"],
  #     ["7", "6", "2", "-", "8", "3", "-", "9", "-"],
  #     ["-", "-", "-", "-", "6", "1", "-", "5", "-"],
  #     ["-", "-", "7", "6", "-", "-", "-", "3", "-"],
  #     ["4", "3", "-", "-", "2", "-", "5", "-", "1"],
  #     ["6", "-", "-", "3", "-", "8", "9", "-", "-"]
  #   ])
  # end

  it '#valid_board returns false if the a row is invalid' do
    game.board[0][1] = "5"
    expect(game.valid_board?).to eq(false)
  end
  it '#valid_board returns false if a column is invalid' do
    game.board[0][1] = "6"
    expect(game.valid_board?).to eq(false)
  end
  it '#valid_board returns false if the grid is invalid' do
    game.board[8][8] = "3"
    expect(game.valid_board?).to eq(false)
  end

  it 'returns a solved board that does not require guesses' do
    expect(game.solve!).to eq([
      ["1", "4", "5", "8", "9", "2", "6", "7", "3"],
      ["8", "9", "3", "1", "7", "6", "4", "2", "5"],
      ["2", "7", "6", "4", "3", "5", "8", "1", "9"],
      ["5", "1", "9", "2", "4", "7", "3", "8", "6"],
      ["7", "6", "2", "5", "8", "3", "1", "9", "4"],
      ["3", "8", "4", "9", "6", "1", "7", "5", "2"],
      ["9", "5", "7", "6", "1", "4", "2", "3", "8"],
      ["4", "3", "8", "7", "2", "9", "5", "6", "1"],
      ["6", "2", "1", "3", "5", "8", "9", "4", "7"]
      ])
  end

  it 'returns tells you a board is invalid' do
    b = "7 2 9 5 1 3 6 8 4 8 1 5 4 6 6 7 3 9 3 6 4 8 7 9 5 2 1 6 8 8 4 4 5 9 7 3 4 9 - 7 8 8 2 6 5 2 5 7 9 6 7 1 4 8 9 3 7 6 9 1 8 5 2 9 8 8 3 - 8 4 1 7 1 8 8 7 8 4 3 9 6".split(" ").join
    expect(Sudoku.new(b).valid_board?).to eq(false)

  end

  it 'returns a solved board that requires guesses' do
    expect(hard_game.solve!).to eq(Sudoku.new("926513784815247639374869521648125973791438265253976148437691852569382417182754396").board)
  end

  it 'returns a blank board solved' do
    expect(blank_game.solve!).to eq([["1", "2", "3", "4", "5", "6", "7", "8", "9"],
       ["4", "5", "6", "7", "8", "9", "1", "2", "3"],
       ["7", "8", "9", "1", "2", "3", "4", "5", "6"],
       ["2", "3", "1", "6", "7", "4", "8", "9", "5"],
       ["8", "7", "5", "9", "1", "2", "3", "6", "4"],
       ["6", "9", "4", "5", "3", "8", "2", "1", "7"],
       ["3", "1", "7", "2", "6", "5", "9", "4", "8"],
       ["5", "4", "2", "8", "9", "7", "6", "3", "1"],
       ["9", "6", "8", "3", "4", "1", "5", "7", "2"]])
  end

end