require 'warehouse'

describe Warehouse do

  let(:crate) { double :crate }

  it 'has dimensions' do
    expect(subject).to respond_to :dimensions
  end

  it 'can contain crates' do
    expect(subject.crates).to eq([])
  end

  it 'responds to receive' do
    expect(subject).to respond_to :receive
  end

  it 'can receive crates' do
    expect(subject.receive(crate)).to eq [crate]
  end
end