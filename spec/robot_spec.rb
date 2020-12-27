require 'robot'

describe Robot do

  it 'has a location' do
    expect(subject).to respond_to :location
  end

  it 'responds to e' do
    expect(subject).to respond_to :instruct
  end

  it 'moves one space east when e is called' do
    
    expect(subject.instruct('e')).to eq [1, 0]
  end

  it 'moves one space west when w is called' do
    expect(subject.instruct('w')).to eq [-1, 0]
  end

  it 'moves one space north when n is called' do
    expect(subject.instruct('n')).to eq [0, 1]
  end

  it 'moves one space south when s is called' do
    expect(subject.instruct('s')).to eq [0, -1]
  end

  it 'does not respond to incorrect instructions' do
    expect(subject.instruct('b')).to eq nil
  end

  it 'will not move outside warehouse north wall' do
    5.times { subject.instruct('n') }
    expect(subject.instruct('n')).to eq [0, 5]
  end

end

