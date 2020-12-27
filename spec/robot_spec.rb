require 'robot'

describe Robot do

  it 'has a location' do
    expect(subject).to respond_to :location
  end

  it 'responds to e' do
    expect(subject).to respond_to :instruct
  end

  it 'moves one space east when e is called' do
    subject.instruct('e')
    expect(subject.location[0]).to eq 1
  end

  it 'moves one space west when w is called' do
    expect(subject.instruct('w')).to eq -1
  end

  it 'moves one space north when n is called' do
    expect(subject.instruct('n')).to eq 1
  end

end

