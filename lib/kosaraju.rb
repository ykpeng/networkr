require_relative "graph.rb"
require "set"

# O(V+E), finds strongly connected component of a directed graph

class Tracker
  attr_accessor :explored, :current_source, :leaders, :current_time,
  :finishing_times

  def initialize
    @explored = Set.new
    #track current source vertex
    @current_source = nil
    @leaders = {}
    #track finishing times/ number of nodes processed so far
    @current_time = 0
    @finishing_times = {}
  end
end

def dfs_loop(graph, tracker)
  graph.keys.reverse_each do |i|
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
  # tracker.leaders[v] = tracker.current_source
  if graph[v] == nil
    tracker.leaders[v] = v
    tracker.current_time += 1
    tracker.finishing_times[v] = tracker.current_time
    stack.pop
  else
    graph[v].each do |w|
      if !tracker.explored.include?(w)
        stack << w
      end
    end
  end
end

def scc(original_graph, graph_rev, tracker, tracker2)
  dfs_loop(graph_rev, tracker)
  # p tracker.finishing_times
  sorted_graph = Hash[original_graph.sort_by { |k, v| tracker.finishing_times[k] }]
  dfs_loop(sorted_graph, tracker2)
end
