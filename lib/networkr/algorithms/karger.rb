require_relative '../graphs/multigraph.rb'
=begin
Karger's algorithm

computes a minumum cut of a connected graph

takes undirected multigraph
=end

def kargerMinCut(g)
  while g.length > 2
    node1 = g.adj.keys.sample
    node2 = g.children_of(node1).keys.sample
    e = [node1, node2]
    contract(g, node1, node2)
  end
  node = g.adj.keys.first
  g.adj[node].length
end

def contract(g, node1, node2)
  g.children_of(node2).each_key do |node|
    g.add_edge(node1, node) if node != node1
    g.remove_edge(node, node2)
    g.add_edge(node, node1) if node != node1
  end
  g.adj.delete(node2)
  g.nodes.delete(node2)
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("kargerMinCut.txt")

  split_int_lines = lines.map do |line|
    line.split.map { |char| char.to_i }
  end

  g = MultiGraph.new

  split_int_lines.each do |line|
    line[1..-1].each do |i|
      g.add_edge(line[0], i)
    end
  end

  # puts g
  # puts kargerMinCut(g)
  g_copy = g.deep_copy

  n = g.length
  mincut = n
  (n ** 3).times do
    mincut = kargerMinCut(g_copy) if kargerMinCut(g_copy) < mincut
  end
  p mincut
end
