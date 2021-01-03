require 'robot'
require 'warehouse'

describe Robot do

  context 'using a warehouse double' do

    let(:warehouse_class) { double :warehouse_class }
    subject(:robot) { described_class.new(warehouse_class) }

    before(:each) do
      allow(warehouse_class).to receive(:crates)
      allow(warehouse_class).to receive(:new)
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
      expect(subject.instruct('n')).to eq "Invalid instruction."
    end

    it 'will not move outside warehouse south wall' do
      5.times { subject.instruct('s') }
      expect(subject.instruct('s')).to eq "Invalid instruction."
    end
  end

  context 'using a real Warehouse' do
    subject(:robot) { described_class.new(Warehouse) }

    it 'can tell if no crate is present' do
      expect(subject.instruct('g')).to eq "No crate to grab."
    end
  end

end

