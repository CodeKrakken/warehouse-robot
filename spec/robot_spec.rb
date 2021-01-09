require 'robot'

describe Robot do

  let(:warehouse) { double :warehouse }
  let(:crate) { double :crate }
  subject(:robot) { described_class.new(warehouse) }

  before(:each) do
    allow(warehouse).to receive(:crates).and_return([crate])
    allow(warehouse).to receive(:check)
    allow(crate).to receive(:location).and_return([0,0])
  end

  it 'has a location' do
    expect(subject).to respond_to :location
  end

  it 'responds to instruct' do
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

  it 'moves one space northeast when ne is called' do
    expect(subject.instruct('ne')).to eq [1, 1]
  end

  it 'moves one space southwest when sw is called' do
    expect(subject.instruct('sw')).to eq [-1, -1]
  end

  it 'moves one space northwest when nw is called' do
    expect(subject.instruct('nw')).to eq [-1, 1]
  end

  it 'moves one space southeast when se is called' do
    expect(subject.instruct('se')).to eq [1, -1]
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

  context 'when holding nothing' do

    before :each do
      expect(subject.crate).to eq nil
    end

    it 'holds a crate once grabbed' do
      allow(warehouse.crates).to receive(:find).and_return(crate)
      expect(subject.instruct('g')).to eq crate
    end
  
    it 'removes crate from warehouse inventory once grabbed' do
      allow(warehouse.crates).to receive(:delete)
      subject.instruct('g')
      expect(warehouse.crates).to have_received(:delete)
    end
  
    it 'will not drop a crate when not holding one' do
      expect(subject.instruct('d')).to eq 'No crate to drop.'
    end

    it 'will not grab a crate if none present at robot location' do
      allow(warehouse.crates).to receive(:find)
      expect(subject.instruct('g')).to eq "No crate to grab."
    end
  end

  context 'when holding a crate' do
    
    before(:each) do
      subject.instruct('g')
      expect(subject.crate).to eq crate
      allow(crate).to receive(:update)
      allow(warehouse.crates).to receive(:push)
    end

    it 'will not grab if holding a crate already' do
      expect(subject.instruct('g')).to eq 'Already holding crate.'
    end

    it 'will return Dropped Crate message when instructed' do
      expect(subject.instruct('d')).to eq 'Dropped crate gently.'   
    end

    it 'will not drop crate on another crate' do
      allow(warehouse).to receive(:check).and_return(true)
      expect(subject.instruct('d')).to eq 'Cannot drop crate here.'
    end

    it 'updates crate location upon drop' do
      subject.instruct('n')
      subject.instruct('d')
      expect(crate).to have_received(:update).with([0,1])
    end

    it 'returns crate to warehouse inventory when dropped' do
      subject.instruct('d')
      expect(warehouse.crates).to have_received(:push)
    end

    it 'will drop the crate it is holding when instructed' do
      expect { subject.instruct('d') }.to change { subject.crate }.from(crate).to(nil)
    end
  end
end
