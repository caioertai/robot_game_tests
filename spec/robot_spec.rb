require_relative '../app'

describe Robot do
  it { is_expected.to respond_to(:position) }
  it { is_expected.to respond_to(:move) }
  it { is_expected.to respond_to(:facing) }
  it { is_expected.to respond_to(:turn_left) }
  it { is_expected.to respond_to(:turn_right) }
  it { is_expected.to respond_to(:errors) }

  let(:empty) { Square.empty }
  let(:wall)  { Square.wall }
  let(:hole)  { Square.hole }

  describe "#turn_right" do
    it "changes facing accordingly" do
      results = [
        { from: :south, to: :west },
        { from: :west, to: :north },
        { from: :north, to: :east },
        { from: :east, to: :south }
      ]
      results.each do |result|
        expect { subject.turn_right }.to change { subject.facing }.from(result[:from]).to(result[:to])
      end
    end
  end

  describe "#turn_left" do
    it "changes facing accordingly" do
      results = [
        { from: :south, to: :east },
        { from: :east, to: :north },
        { from: :north, to: :west },
        { from: :west, to: :south }
      ]
      results.each do |result|
        expect { subject.turn_left }.to change { subject.facing }.from(result[:from]).to(result[:to])
      end
    end
  end

  describe "#move" do
    it "changes position according to facing" do
      squares = [[empty, empty], [empty, empty]]
      subject.instance_eval { @board = Board.new(squares: squares) }
      subject.instance_eval { @facing = :east }
      expect { subject.move }.to change { subject.position }.from([1, 1]).to([2, 1])
      subject.instance_eval { @facing = :west }
      expect { subject.move }.to change { subject.position }.from([2, 1]).to([1, 1])
      subject.instance_eval { @facing = :south }
      expect { subject.move }.to change { subject.position }.from([1, 1]).to([1, 2])
      subject.instance_eval { @facing = :north }
      expect { subject.move }.to change { subject.position }.from([1, 2]).to([1, 1])
    end

    it 'assigns no errors if it moves succesfully' do
      board = Board.new(squares: [[empty], [empty]])
      subject.instance_eval { @board = board }
      expect { subject.turn_right.move }.not_to(change { subject.errors })
    end

    it 'assigns oob error if it moves out of the board' do
      board = Board.new(squares: [[empty]])
      subject.instance_eval { @board = board }
      expect { subject.move }.to change { subject.errors }.from({}).to(oob: 'Curiosity crashed into a wall.')
    end

    it 'assigns crashed error if it moves into a wall' do
      board = Board.new(
        squares:  [
          [empty],
          [wall]
        ]
      )
      subject.instance_eval { @board = board }
      expect { subject.move }.to change { subject.errors }.from({}).to(crashed: 'Curiosity crashed into a wall.')
    end

    it 'assigns felt error if it moves into a hole' do
      board = Board.new(squares: [[empty], [hole]])
      subject.instance_eval { @board = board }
      expect { subject.move }.to change { subject.errors }.from({}).to(felt: 'Curiosity felt into a hole.')
    end

    it "executes n times when given an integer as argument" do
      board = Board.new(squares: [[empty], [empty], [empty]])
      subject.instance_eval { @board = board }
      expect { subject.move(2) }.to change { subject.position }.from([1, 1]).to([1, 3])
    end
  end

  describe "#inspect" do
    it "prints the board if no errors" do
      board = Board.new(squares: [[empty], [hole]])
      subject.instance_eval { @board = board }
      expect(subject.inspect).to match(/\nR \n◼ /)
    end

    it "prints the error message if it has errors" do
      error = { felt: 'Curiosity felt into a hole.' }
      subject.instance_eval { @errors = error }
      expect(subject.inspect).to include(error)
    end
  end
end
