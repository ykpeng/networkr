require_relative "../graphs/graph.rb"
=begin
Prim's algorithm for calculating minimum spanning tree.

takes weighted, undirected graph
returns tree
=end

def prims_MST(g, start)
  vertices_spanned = [start]
  tree_so_far = Graph.new
  while vertices_spanned.length != g.length
    e = min_edge(vertices_spanned, g)
    puts e
    tree_so_far.add_edge(e[0][0], e[0][1], weight: e[1])
    vertices_spanned << e[0][1]
  end
  tree_so_far
end

def min_edge(vertices_spanned, g)
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

# def total_cost(tree)
#   sum = 0
#   tree.adj.each do |src, options|
#     sum += option
#   end
#   p sum
# end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("test10.txt")
  number_of_nodes = lines[0].split[0].to_i
  number_of_edges = lines[0].split[1].to_i
  g = Graph.new
  lines[1..-1].each do |line|
    split_line = line.split.map { |str| str.to_i }
    g.add_edge(split_line[0], split_line[1], weight: split_line[2])
  end
  # puts g
  start = rand(number_of_nodes + 1)
  min_spanning_tree = prims_MST(g, start)
  puts min_spanning_tree
  # total_cost(min_spanning_tree)
end
