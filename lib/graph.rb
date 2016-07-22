require 'set'

# class Node
#   attr_accessor :name
#
#   def initialize(name)
#     @name = name.to_s
#   end
#
#   def to_s
#     @name
#   end
#
#   def ==(other)
#     @name == other.name
#   end
#
#   def hash
#     @name.hash
#   end
# end

# class Edge
#   attr_accessor :src, :dest
#
#   def initialize(src, dest)
#     @src, @dest = src, dest
#   end
#
#   def to_s
#     "#{@src}->#{@dest}"
#   end
# end
#
# class WeightedEdge < Edge
#   #A weighted edge
#   attr_accessor :weight
#
#   def initialize(src, dest, weight)
#     super(src, dest)
#     @weight = weight
#   end
#
#   def to_s
#     "#{@src}->#{@dest} (#{@weight})"
#   end
# end

class Graph
  attr_accessor :name, :nodes, :adj

  def initialize(name)
    @name = name
    @nodes = []
    @adj = {}
  end

  def add_node(node)
    if @nodes.include?(node)
      raise "Duplicate node"
    else
      @nodes << node
      @adj[node] = {}
    end
  end

  def remove_node(node)
    if @nodes.include?(node)
      @nodes.delete(node)
    else
      raise "Node not in graph"
    end

    nbrs = @adj[node].keys
    nbrs.each do |nbr|
      @adj[nbr].delete(node)
    end
    @adj.delete(node)
  end

  def add_edge(edge)
    src = edge.src
    dest = edge.dest
    if !(@nodes.include?(src) && @nodes.include?(dest))
      raise "Node not in graph"
    end
    @adj[src] << dest
  end

  def children_of(node)
    @adj[node]
  end

  def has_node(node)
    @nodes.include?(node)
  end

  def length
    @nodes.length
  end

  def to_s
    res = ''
    @adj.each do |src, dests|
      dests.each do |dest|
        res = "#{res}#{src}->#{dest}\n"
      end
    end
    res[0...-1]
  end
end

class WeightedGraph < Graph
  def add_edge(edge)
    src = edge.src
    dest = edge.dest
    weight = edge.weight
    if !(@nodes.include?(src) && @nodes.include?(dest))
      raise "Node not in graph"
    end
    @adj[src] << { dest: dest, weight: weight }
  end

  def to_s
    res = ''
    @adj.each do |key, val|
      val.each do |val|
        res = "#{res}#{key}->#{val[:dest]} (#{val[:weight]})\n"
      end
    end
    res[0...-1]
  end
end
