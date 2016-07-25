module Networkr

  # Prim's algorithm for finding a minimum spanning tree for a weighted undirected graph.
  #
  # @param g [Networkr::Graph] weighted, undirected graph
  # @param source_node random node in graph, can be any hashable object
  # @return [Networkr::Graph] minimum spanning tree
  #
  # Complexity: O(|V|**2)
  class << self
    def prim(g, source_node)
      nodes_spanned = [source_node]
      tree_so_far = Graph.new
      while nodes_spanned.length != g.length
        e = min_edge(g, nodes_spanned)
        tree_so_far.add_edge(e[0][0], e[0][1], weight: e[1])
        nodes_spanned << e[0][1]
      end
      tree_so_far
    end

    private
    def min_edge(g, nodes_spanned)
      min_edge = nil
      min_cost = 1.0/0
      nodes_spanned.each do |u|
        if g.adj[u]
          g.adj[u].each do |v, options|
            if !nodes_spanned.include?(v) && options[:weight] < min_cost
              min_edge = [u, v]
              min_cost = options[:weight]
            end
          end
        end
      end
      [min_edge, min_cost]
    end
  end
end
