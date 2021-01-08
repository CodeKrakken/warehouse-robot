require 'warehouse'

describe Warehouse do

  let(:crate) { double :crate }
  let(:crate_2) { double :crate }

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
    allow(crate).to receive(:location)
    expect(subject.receive(crate)).to eq [crate]
  end

  it 'will not receive a crate if already in crates array' do
    allow(crate).to receive(:location)
    subject.receive(crate)
    expect(subject.receive(crate)).to eq 'Crate already in warehouse.'
  end

  it 'will not receive a crate in same location as existing one' do
    allow(crate).to receive(:location).and_return([0, 0])
    allow(crate_2).to receive(:location).and_return([0, 0])
    subject.receive(crate)
    expect(subject.receive(crate_2)).to eq 'Position occupied.'
  end
end