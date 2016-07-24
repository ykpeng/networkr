# dijkstra
# single-source shortest path

#Takes undirected, weighted graph, nonnegative weights
# O(|V|**2)
module Networkr
  def self.dijkstra(g, source_node)
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
end
