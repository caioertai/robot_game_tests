require_relative '../app'

describe Board do
  it { is_expected.to respond_to(:square_at).with(1).argument }

  describe "#square_at" do
    it "return the correct state" do
      first  = Square.new(:first)
      second = Square.new(:second)
      third  = Square.new(:third)
      fourth = Square.new(:fourth)
      board = Board.new(
        squares: [
          [first, second],
          [third, fourth]
        ]
      )
      expect(board.square_at([1, 1])).to eq(first)
      expect(board.square_at([2, 1])).to eq(second)
      expect(board.square_at([1, 2])).to eq(third)
      expect(board.square_at([2, 2])).to eq(fourth)
    end

    it "return oob square if out of bounds" do
      first = Square.new(:first)
      board = Board.new(squares: [[first]])
      expect(board.square_at([100, 100]).state).to eq(:oob)
    end
  end

  describe "#to_s" do
    it "returns a boards ASCII" do
      subject.instance_eval { @squares = [[Square.empty], [Square.hole]] }
      expect(subject.to_s).to match(/\n◻ \n◼ /)
    end
  end
end
