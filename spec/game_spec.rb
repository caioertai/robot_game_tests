require_relative '../app'

describe Game do
  it { is_expected.to respond_to(:board) }
  it { is_expected.to respond_to(:robot) }
end
