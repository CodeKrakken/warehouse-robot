require 'robot'

describe Robot do

  it 'has a location' do
    expect(subject).to respond_to :location
  end

  it 'responds to e' do
    expect(subject).to respond_to :e
  end

end