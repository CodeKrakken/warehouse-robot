require 'crate'

describe Crate do

  it 'responds to location' do
    expect(subject).to respond_to(:location)
  end

  it 'can update its location when dropped by robot' do
    expect(subject.update([0, 1])).to eq ([0, 1])
  end

end