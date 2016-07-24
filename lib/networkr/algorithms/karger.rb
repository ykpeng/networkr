=begin
Karger's algorithm

computes a minumum cut of a connected graph

takes undirected multigraph
=end

module Networkr
  def self.karger(g)
    while g.length > 2
      node1 = g.adj.keys.sample
      node2 = g.children_of(node1).keys.sample
      e = [node1, node2]
      contract(g, node1, node2)
    end
    node1 = g.adj.keys[0]
    node2 = g.adj.keys[1]
    g.adj[node1][node2].length
  end

  def self.contract(g, node1, node2)
    g.children_of(node2).each_key do |node|
      g.add_edge(node1, node) if node != node1
      g.adj[node].delete(node2)
    end
    g.adj.delete(node2)
    g.nodes.delete(node2)
  end

  def self.karger_repeated(g)
    g_copy = g.deep_copy

    n = g.length
    mincut = n
    (n ** 3).times do
      mincut = karger(g_copy) if karger(g_copy) < mincut
    end
    mincut
  end
end
