require 'crate'

describe Crate do

  let(:robot) { double :robot }

  it 'responds to location' do
    expect(subject).to respond_to(:location)
  end

  it 'can update its location when dropped by robot' do
    subject.update([0, 1])
    expect(subject.location).to eq ([0, 1])

  end

end