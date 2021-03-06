module Networkr

  # Dijkstra's algorithm for computing the shortest paths from a single source.
  #
  # @param g [Networkr::Graph] an undirected, weighted graph. Weights must be non-negative.
  # @param source_node node in the graph, can be any hashable object
  # @return [Hash] with destination nodes as keys and distances as values
  #
  # Complexity: O(|V|**2)
  class << self
    def dijkstra(g, source_node)
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
end
