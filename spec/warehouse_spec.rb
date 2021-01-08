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
    allow(crate).to receive(:update)
    expect(subject.receive(crate, 0, 0)).to eq [crate]
  end

  it 'adds location to crate when received' do
    allow(crate).to receive(:update)
    allow(crate).to receive(:location)
    subject.receive(crate, 0, 0)
    expect(crate).to have_received(:update)
  end

  it 'will not receive a crate if already in crates array' do
    allow(crate).to receive(:location)
    allow(crate).to receive(:update)
    subject.receive(crate, 0, 0)
    expect(subject.receive(crate, 0, 1)).to eq 'Crate already in warehouse.'
  end

  it 'will not receive a crate in same location as existing one' do
    allow(crate).to receive(:location).and_return([0, 0])
    allow(crate_2).to receive(:location).and_return([0, 0])
    allow(crate).to receive(:update)
    allow(crate_2).to receive(:update)
    subject.receive(crate, 0, 0)
    expect(subject.receive(crate_2, 0, 0)).to eq 'Position occupied.'
  end
end