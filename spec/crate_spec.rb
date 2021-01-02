require 'crate'

describe Crate do

  subject(:crate) { described_class.new(5, 5) }

  it 'responds to location' do
    expect(subject).to respond_to(:location)
  end

  it 'can be created in a specific location' do
    expect(subject.location).to eq ([5, 5])
  end
end