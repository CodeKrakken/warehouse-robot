# frozen_string_literal: true

require 'warehouse'

describe Warehouse do
  let(:crate) { double :crate }
  let(:crate2) { double :crate }

  before(:each) do
    allow(crate).to receive(:location).and_return([0, 0])
    allow(crate).to receive(:update)
  end

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
    expect(subject.receive(crate, 0, 0)).to eq [crate]
  end

  it 'adds location to crate when received' do
    subject.receive(crate, 0, 0)
    expect(crate).to have_received(:update)
  end

  it 'will not receive a crate if already in crates array' do
    subject.receive(crate, 0, 0)
    expect(subject.receive(crate, 0, 1)).to eq 'Crate already in warehouse.'
  end

  it 'will not receive a crate in same location as existing one' do
    allow(crate2).to receive(:location).and_return([0, 0])
    allow(crate2).to receive(:update)
    subject.receive(crate, 0, 0)
    expect(subject.receive(crate2, 0, 0)).to eq 'Position occupied.'
  end
end
