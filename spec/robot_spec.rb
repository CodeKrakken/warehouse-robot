require 'robot'

describe Robot do

  it 'has a location' do
    expect(subject).to respond_to :location
  end

  it 'responds to e' do
    expect(subject).to respond_to :e
  end

  it 'moves one space east when e is called' do
    subject.e
    expect(subject.location[0]).to eq 1
  end

end

