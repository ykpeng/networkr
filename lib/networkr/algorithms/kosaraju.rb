require "set"

module Networkr

  # Kosaraju's algorithm for finding the strongly connected components of a directed graph.
  #
  # Complexity: O(V+E)
  class << self

    # @param g [Networkr::DiGraph] a directed graph
    # @param g_rev [Networkr::DiGraph] reversed graph of g
    # @return [Array<Numeric>] sizes (numbers of nodes) of strongly connected components in descending order
    def kosaraju_scc_sizes(original_g, g_rev)
      tracker1 = Tracker.new
      tracker2 = Tracker.new
      tracker2 = kosaraju(original_g, g_rev, tracker1, tracker2)
      sizes(tracker2)
    end

    # @param g [Networkr::DiGraph] a directed graph
    # @param g_rev [Networkr::DiGraph] reversed graph of g
    # @return [Numeric] number of strongly connected components
    def kosaraju_num_scc(original_g, g_rev)
      tracker1 = Tracker.new
      tracker2 = Tracker.new
      tracker2 = kosaraju(original_g, g_rev, tracker1, tracker2)
      num_scc(tracker2)
    end

    private
    def kosaraju(original_g, g_rev, tracker1, tracker2)
      dfs_loop(g_rev, tracker1)
      sorted_g_adj = Hash[original_g.adj.sort_by { |k, v| tracker1.finishing_times[k] }]
      sorted_g = DiGraph.new
      sorted_g.adj = sorted_g_adj
      dfs_loop(sorted_g, tracker2)
      tracker2
    end

    def dfs_loop(g, tracker)
      g.adj.keys.reverse_each do |i|
        stack = [i]
        tracker.current_source = i
        while !stack.empty?
          v = stack.last
          if !tracker.explored.include?(v)
            dfs(g, stack, v, tracker)
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

    def dfs(g, stack, v, tracker)
      tracker.explored << v
      if !g.adj[v]
        tracker.leaders[v] = v
        tracker.current_time += 1
        tracker.finishing_times[v] = tracker.current_time
        stack.pop
      else
        g.adj[v].each_key do |w|
          if !tracker.explored.include?(w)
            stack << w
          end
        end
      end
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
end
