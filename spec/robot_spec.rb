require 'robot'

describe Robot do

  context 'using a warehouse double' do

    let(:warehouse) { double :warehouse }
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
      expect(subject.instruct('n')).to eq "Invalid instruction."
    end

    it 'will not move outside warehouse south wall' do
      5.times { subject.instruct('s') }
      expect(subject.instruct('s')).to eq "Invalid instruction."
    end

    it 'will not grab if no crate is present in warehouse' do
      allow(warehouse.crates.length).to receive(:>)
      expect(subject.instruct('g')).to eq "No crate to grab."
    end

    it 'will grab a crate if present in warehouse' do
      allow(warehouse.crates.length).to receive(:>).and_return(true)
      expect(subject.instruct('g')).to eq "Grabbed crate."
    end

    it 'will not grab a crate if none present at robot location' do
      allow(warehouse.crates.length).to receive(:>)
      expect(subject.instruct('g')).to eq "No crate to grab."
    end

  end
end

