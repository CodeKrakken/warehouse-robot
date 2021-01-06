require 'robot'

describe Robot do

  let(:warehouse) { double :warehouse }
  let(:crate) { double :crate }
  let(:crate_2) { double :crate }
  subject(:robot) { described_class.new(warehouse) }

  before(:each) do
    allow(warehouse).to receive(:new)
    allow(warehouse).to receive(:crates)
    allow(warehouse.crates).to receive(:length)
  end

  it 'has a location' do
    expect(subject).to respond_to :location
  end

  it 'responds to e' do
    expect(subject).to respond_to :instruct
  end

  it 'moves one space east when e is called' do
    expect(subject.instruct('e')).to eq [1, 0]
  end

  it 'moves one space west when w is called' do
    expect(subject.instruct('w')).to eq [-1, 0]
  end

  it 'moves one space north when n is called' do
    expect(subject.instruct('n')).to eq [0, 1]
  end

  it 'moves one space south when s is called' do
    expect(subject.instruct('s')).to eq [0, -1]
  end

  it 'does not respond to incorrect instructions' do
    expect(subject.instruct('b')).to eq "Invalid instruction."
  end

  it 'will not move outside warehouse north wall' do
    5.times { subject.instruct('n') }
    expect(subject.instruct('n')).to eq "Cannot move there."
  end

  it 'will not move outside warehouse south wall' do
    5.times { subject.instruct('s') }
    expect(subject.instruct('s')).to eq "Cannot move there."
  end

  it 'will not move outside warehouse east wall' do
    5.times { subject.instruct('e') }
    expect(subject.instruct('e')).to eq "Cannot move there."
  end

  it 'will not move outside warehouse west wall' do
    5.times { subject.instruct('w') }
    expect(subject.instruct('w')).to eq "Cannot move there."
  end

  it 'will not grab a crate if none present at robot location' do
    allow(warehouse.crates.length).to receive(:>).and_return(true)
    allow(warehouse.crates).to receive(:each).and_return('No crate to grab.')
    expect(subject.instruct('g')).to eq "No crate to grab."
  end

  it 'holds a crate once grabbed' do
    allow(warehouse.crates).to receive(:each).and_return(crate)
    expect(subject.instruct('g')).to eq (crate)
  end

  it 'removes crate from warehouse inventory once grabbed' do
    allow(warehouse).to receive(:crates).and_return([crate])
    allow(warehouse.crates).to receive(:delete)
    allow(crate).to receive(:location).and_return([0,0])
    subject.instruct('g')
    expect(warehouse.crates).to have_received(:delete)
  end

  it 'will not grab if holding a crate already' do
    allow(warehouse).to receive(:crates).and_return([crate, crate_2])
    allow(crate).to receive(:location).and_return([0,0])
    subject.instruct('g')
    allow(crate).to receive(:location).and_return([0,1])
    subject.instruct('n')
    expect(subject.instruct('g')).to eq 'Already holding crate.'
  end

  it 'will return Dropped Crate message when instructed' do
    allow(warehouse).to receive(:crates).and_return([crate, crate_2])
    allow(crate).to receive(:location).and_return([0,0])
    allow(crate_2).to receive(:location).and_return([5,5])
    subject.instruct('g')
    # binding.pry
    expect(subject.instruct('d')).to eq 'Dropped crate gently.'  
  end

  it 'will drop the crate it is holding when instructed' do
    allow(warehouse).to receive(:crates).and_return([crate, crate_2])
    allow(crate).to receive(:location).and_return([0,0])
    allow(crate_2).to receive(:location).and_return([5,5])
    subject.instruct('g')
    subject.instruct('d')
    expect(subject.crate).to eq nil
  end

  it 'returns crate to warehouse inventory when dropped' do
    allow(warehouse).to receive(:crates).and_return([crate, crate_2])
    allow(crate).to receive(:location).and_return([0,0])
    allow(crate_2).to receive(:location).and_return([5,5])
    allow(warehouse.crates).to receive(:push)
    subject.instruct('g')
    subject.instruct('d')
    expect(warehouse.crates).to have_received(:push)
  end

  it 'will not drop a crate when not holding one' do
    allow(warehouse.crates).to receive(:push)
    expect(subject.instruct('d')).to eq 'No crate to drop.'
  end

  it 'will not drop crate on another crate' do
    allow(warehouse).to receive(:crates).and_return([crate, crate_2])
    allow(crate).to receive(:location).and_return([0,0])
    allow(crate_2).to receive(:location).and_return([0,0])
    subject.instruct('g')
    # binding.pry
    expect(subject.instruct('d')).to eq 'Cannot drop crate here.'
  end
end
