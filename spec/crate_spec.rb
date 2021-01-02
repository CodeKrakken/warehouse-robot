require 'crate'

describe Crate do
  it 'responds to location' do
    expect(subject).to respond_to(:location)
  end

  it 'has a location' do
    expect(subject.location).to eq [0,0]
  end
end