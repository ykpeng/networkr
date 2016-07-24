require "set"

# O(V+E), finds strongly connected components of a directed graph

module Networkr
  class Tracker
    attr_accessor :explored, :current_source, :leaders, :current_time,
    :finishing_times

    def initialize
      @explored = Set.new
      @current_source = nil
      @leaders = {}
      @current_time = 0
      @finishing_times = {}
    end
  end

  class << self
    def dfs_loop(graph, tracker)
      graph.adj.keys.reverse_each do |i|
        stack = [i]
        tracker.current_source = i
        while !stack.empty?
          v = stack.last
          if !tracker.explored.include?(v)
            dfs(graph, stack, v, tracker)
          else
            if tracker.finishing_times[v] == nil
              tracker.leaders[v] = tracker.current_source
              tracker.current_time += 1
              tracker.finishing_times[v] = tracker.current_time
            end
            stack.pop
          end
        end
      end
    end

    def dfs(graph, stack, v, tracker)
      tracker.explored << v
      if !graph.adj[v]
        tracker.leaders[v] = v
        tracker.current_time += 1
        tracker.finishing_times[v] = tracker.current_time
        stack.pop
      else
        graph.adj[v].each_key do |w|
          if !tracker.explored.include?(w)
            stack << w
          end
        end
      end
    end

    def kosaraju(original_graph, graph_rev, tracker1, tracker2)
      dfs_loop(graph_rev, tracker1)
      sorted_graph_adj = Hash[original_graph.adj.sort_by { |k, v| tracker1.finishing_times[k] }]
      sorted_graph = DiGraph.new
      sorted_graph.adj = sorted_graph_adj
      dfs_loop(sorted_graph, tracker2)
      tracker2
    end

    def kosaraju_scc_sizes(original_graph, graph_rev, tracker1, tracker2)
      tracker2 = kosaraju(original_graph, graph_rev, tracker1, tracker2)
      sizes(tracker2)
    end

    def kosaraju_num_scc(original_graph, graph_rev, tracker1, tracker2)
      tracker2 = kosaraju(original_graph, graph_rev, tracker1, tracker2)
      num_scc(tracker2)
    end

    def sizes(tracker2)
      frequencies = Hash.new(0)
      tracker2.leaders.each do |k, v|
        frequencies[v] += 1
      end

      frequencies.values.sort.reverse
    end

    def num_scc(tracker2)
      tracker2.leaders.length
    end
  end
end
