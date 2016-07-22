require_relative "../graphs/graph.rb"
# dijkstra
# single-source shortest path

#Takes undirected, weighted graph

def dijkstra_shortest_path(source_node, g)
  nodes_processed = [source_node]
  shortest_path_distances = {}
  shortest_path_distances[source_node] = 0

  while nodes_processed.length != g.length
    shortest = nil
    start_node = nil
    end_node = nil
    nodes_processed.each do |node|
      g.children_of(node).each do |v, options|
        if !nodes_processed.include?(v)
          if shortest.nil? || shortest_path_distances[node] + options[:weight] < shortest
            shortest = shortest_path_distances[node] + options[:weight]
            start_node = node
            end_node = v
          end
        end
      end
    end
    nodes_processed << end_node
    shortest_path_distances[end_node] = shortest
  end
  shortest_path_distances
end

def dijkstra_shortest_path_target(source_node, g, target)
  shortest_path_distances = dijkstra_shortest_path(source_node, g)
  shortest_path_distances[target]
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("test1.txt")
  split_lines = lines.map do |line|
    split_space = line.split
  end

  g = Graph.new

  split_lines.each do |line|
    line[1..-1].each do |dest|
      dest = dest.split(",")
      g.add_edge( line[0].to_i, dest[0].to_i, { weight: dest[1].to_i } )
    end
  end

  puts dijkstra_shortest_path(1, g)
end
