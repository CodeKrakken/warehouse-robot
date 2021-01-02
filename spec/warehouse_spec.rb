require 'warehouse'

describe Warehouse do

  it 'has dimensions' do
    expect(subject).to respond_to :dimensions
  end

  it 'can contain crates' do
    expect(subject.crates).to eq([])
  end
end