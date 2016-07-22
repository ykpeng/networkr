require_relative '../graphs/multigraph.rb'

def kargerMinCut(g)
  while g.length > 2
    node1 = g.nodes.keys.sample
    node2 = g.children_of(node1).keys.sample
    e = [node1, node2]
    contract(g, node1, node2)
  end
  g.edges[g.nodes[0]].length
end

def contract(g, node1, node2)
  g.edges[node2].each do |node|
    g.edges[node1] << node if node != node1
    g.edges[node].delete(node2)
    g.edges[node] << node1 if node != node1
  end
  g.edges.delete(node2)
end

def deep_copy(o)
  Marshal.load(Marshal.dump(o))
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

  puts g
  # puts kargerMinCut(g)
  # g_copy = deep_copy(g)
  #
  # n = g.nodes.length
  # mincut = n
  # (n ** 3).times do
  #   mincut = kargerMinCut(g_copy) if kargerMinCut(g_copy) < mincut
  # end
  # p mincut
end
