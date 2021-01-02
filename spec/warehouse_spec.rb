require 'warehouse'

describe Warehouse do

  it 'has dimensions' do
    expect(subject).to respond_to :dimensions
  end
end