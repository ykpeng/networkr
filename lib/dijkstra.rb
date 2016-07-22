require_relative "graph.rb"
# dijkstra
# single-source shortest path

#Takes undirected, weighted graph

def dijkstra_shortest_path(source_node, graph)
  nodes_processed = [source_node]
  shortest_path_distances = {}
  shortest_path_distances[source_node] = 0

  while nodes_processed.length != graph.nodes.length
    shortest = nil
    start_node = nil
    end_node = nil
    nodes_processed.each do |node|
      graph.edges[node].each do |edge|
        if !nodes_processed.include?(edge[:dest])
          if shortest.nil? || shortest_path_distances[node] + edge[:weight] < shortest
            shortest = shortest_path_distances[node] + edge[:weight]
            start_node = node
            end_node = edge[:dest]
          end
        end
      end
    end
    nodes_processed << end_node
    shortest_path_distances[end_node] = shortest
  end
  shortest_path_distances
end

def dijkstra_shortest_path_target(source_node, graph, target)
  shortest_path_distances = dijkstra_shortest_path(source_node, graph)
  shortest_path_distances[target]
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("test1.txt")
  split_lines = lines.map do |line|
    split_space = line.split
  end

  graph = WeightedGraph.new

  nodes = {}
  split_lines.each do |line|
    node = Node.new(line[0].to_i)
    graph.add_node(node)
    nodes[line[0].to_i] = node
  end

  split_lines.each do |line|
    line[1..-1].each do |dest|
      dest = dest.split(",")
      edge = WeightedEdge.new(nodes[line[0].to_i],nodes[dest[0].to_i], dest[1].to_i)
      graph.add_edge(edge)
    end
  end

  puts dijkstra_shortest_path(nodes[1], graph)
end
