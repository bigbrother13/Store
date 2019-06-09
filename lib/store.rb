class Store
  class Node
    attr_accessor :key, :value, :next, :prev
  
    def initialize(key:, value:, prev: nil)
      @key   = key
      @value = value
      @prev  = prev
      @next  = nil
    end

    def find(key)
      node = self
      node = node.next while node.key != key && node.next
      node
    end

    def last  
      node = self
      node = node.next while node.next
      node
    end

    def delete
      if !prev.nil?
        self.next&.prev = self.prev
        self.prev.next  = self.next
      end
    end
  end

  SIZE = 10

  def initialize
    @store = Array.new(SIZE)
  end

  def []=(key, value)
    i = index(key)
    if @store[i].nil?
      @store[i] = Node.new(key: key, value: value)
    elsif @store[i].key != key
      current = @store[i].last
      if current.key == key
        current.value = value
      else
        current.next = Node.new(key: key, value: value, prev: current)
      end 
    else
      @store[i].value = value
    end
  end
  
  def [](key)
    find(key)&.value
  end

  def delete(key)
    node = find(key)
    @store[index(key)] = node.next if node && node.prev.nil?
    node.delete if node&.key == key
  end

  def to_s
    
  end

  private

  def find(key)
    node = nodes_at(key)&.find(key)
    node&.key == key ? node : nil
  end

  def nodes_at(key)
    i = index(key)
    @store[i]
  end

  def index(key)
    key.chars.map(&:ord).reduce(&:+) % SIZE
  end
end

my_hash = Store.new
my_hash['bea'] = 1
my_hash['bea'] = 2
my_hash['mea'] = 3
my_hash['eam'] = 3
my_hash['aem'] = 4
p my_hash


