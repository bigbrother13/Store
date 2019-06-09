require 'minitest/autorun'
require_relative '../lib/store'

describe 'Store' do
  it 'can search in an empty hash' do
    my_hash = Store.new
    expect(my_hash['aeb']).to eq(nil)
  end

  it 'can add one items' do
    my_hash = Store.new
    my_hash['bae'] = 3
    expect(my_hash['bae']).to eq(3)
  end

  it 'can add two items' do
    my_hash = Store.new
    my_hash['Bea'] = 1
    my_hash['Mea'] = 2
    expect(my_hash['Bea']).to eq(1)
    expect(my_hash['Mea']).to eq(2)
  end

  it 'can resolve collisions' do
    my_hash = Store.new
    my_hash['bea'] = 1
    my_hash['bea'] = 3
    my_hash['aeb'] = 2
    expect(my_hash['bea']).to eq(3)
    expect(my_hash['aeb']).to eq(2)
    expect(my_hash['abe']).to eq(nil)
  end

  it 'can update an item' do
    my_hash = Store.new
    my_hash['Bea'] = 1
    my_hash['Bea'] = 2
    expect(my_hash['Bea']).to eq(2)
  end

  it 'can update an item in a collision' do
    my_hash = Store.new
    my_hash['bea'] = 1
    my_hash['eab'] = 2
    my_hash['eab'] = 3
    expect(my_hash['eab']).to eq(3)
  end

  it 'returns nil when deleting from an empty hash' do
    my_hash = Store.new
    expect(my_hash.delete('bea')).to eq(nil)
  end

  it 'can delete a single item' do
    my_hash = Store.new
    my_hash['mea'] = 2
    my_hash.delete('mea')
    expect(my_hash['mea']).to be_nil
  end

  it 'can delete the first item' do
    my_hash = Store.new
    my_hash['bea'] = 1
    my_hash['aeb'] = 2
    my_hash.delete('bea')
    expect(my_hash['bea']).to be_nil
  end

  it 'can delete an item in the middle' do
    my_hash = Store.new
    my_hash['bea'] = 1
    my_hash['aeb'] = 2
    my_hash['abe'] = 3
    my_hash.delete('aeb')
    expect(my_hash['aeb']).to be_nil
  end

  it 'can delete the last item' do
    my_hash = Store.new
    my_hash['bea'] = 1
    my_hash['aeb'] = 2
    my_hash.delete('aeb')
    expect(my_hash['aeb']).to be_nil
  end
end

