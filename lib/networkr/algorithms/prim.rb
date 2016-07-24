=begin
Prim's algorithm for calculating minimum spanning tree.

takes weighted, undirected graph
returns tree
=end
module Networkr
  def self.prim(g, start)
    vertices_spanned = [start]
    tree_so_far = Graph.new
    while vertices_spanned.length != g.length
      e = min_edge(g, vertices_spanned)
      tree_so_far.add_edge(e[0][0], e[0][1], weight: e[1])
      vertices_spanned << e[0][1]
    end
    tree_so_far
  end

  def self.min_edge(g, vertices_spanned)
    min_edge = nil
    min_cost = 1.0/0
    vertices_spanned.each do |u|
      if g.adj[u]
        g.adj[u].each do |v, options|
          if !vertices_spanned.include?(v) && options[:weight] < min_cost
            min_edge = [u, v]
            min_cost = options[:weight]
          end
        end
      end
    end
    [min_edge, min_cost]
  end
end
