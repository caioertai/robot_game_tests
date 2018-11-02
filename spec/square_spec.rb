require_relative '../app'

describe Square do
  it { is_expected.to respond_to(:state) }
  it { is_expected.to respond_to(:result) }
end