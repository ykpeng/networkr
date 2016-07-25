module Networkr

  # Karger's algorithm for computing a minimum cut of a connected graph
  #
  # @param g [Networkr::MultiGraph] an undirected multigraph
  # @return [Numeric] the number of edges crossed by minimum cut
  # @note Karger's algorithm is a randomized algorithm and does not guarantee to return the minimum cut. However, running the algorithm |V|**2 log|V| times produces a minimum cut with high probability. Use Networkr::karger to run the algorithm once. Use Networkr::karger_repeated to run it |V|**2 log|V| times.
  #
  # Complexity (of running Networkr::karger once): O(|V|**2)
  class << self
    def karger(g)
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

    def karger_repeated(g)
      g_copy = g.deep_copy

      n = g.length
      mincut = n
      (n ** 2 * Math.log(n)).to_i.times do
        mincut = karger(g_copy) if karger(g_copy) < mincut
      end
      mincut
    end

    private
    def contract(g, node1, node2)
      g.children_of(node2).each_key do |node|
        g.add_edge(node1, node) if node != node1
        g.adj[node].delete(node2)
      end
      g.adj.delete(node2)
      g.nodes.delete(node2)
    end
  end
end
