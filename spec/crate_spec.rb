require 'crate'

describe Crate do

  subject(:crate) { described_class.new(0, 0) }
  let(:robot) { double :robot }

  it 'responds to location' do
    expect(subject).to respond_to(:location)
  end

  it 'can be initialised in a specific location' do
    expect(subject.location).to eq ([0, 0])
  end

  it 'can update its location when dropped by robot' do
    subject.update([0, 1])
    expect(subject.location).to eq ([0, 1])

  end

end