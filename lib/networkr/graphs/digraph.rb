module Networkr
  
  # Class for directed graphs.
  #
  # DiGraphs hold directed edges. Self loops are allowed but parallel edges are not.
  #
  # See Also
  # --------
  # Graph
  # MultiGraph
  class DiGraph < Graph

    attr_accessor :pred, :succ

    def initialize(options={})
      super(options)
      @pred = {}
      @succ = @adj
    end

    def add_node(node, options={})
      if !@succ.include?(node)
        @succ[node] = {}
        @pred[node] = {}
        @nodes[node] = options
      else
        @nodes[node].merge!(options)
      end
    end

    def remove_node(node)
      if @nodes[node]
        @nodes.delete(node)
      else
        raise NetworkrError, "Node #{node} is not in graph"
      end

      nbrs = @succ[node]
      nbrs.each_key do |u|
        @pred[u].delete(node)
      end
      @succ.delete(node)

      @pred[node].each_key do |u|
        @succ[u].delete(node)
      end
      @pred.delete(node)
    end

    def add_edge(u, v, options={})
      if !@succ[u]
        @succ[u] = {}
        @pred[u] = {}
        @nodes[u] = {}
      end
      if !@succ[v]
        @succ[v] = {}
        @pred[v] = {}
        @nodes[v] = {}
      end
      data = @adj[u][v] || {}
      data.merge!(options)
      @succ[u][v]=data
      @pred[v][u]=data
    end

    def remove_edge(u, v)
      if @succ[u] && @succ[u][v]
        @succ[u].delete(v)
        @pred[v].delete(u)
      else
        raise NetworkrError, "Edge #{u}->#{v} not in graph"
      end
    end

    def has_successor?(u, v)
      @succ[u] && @succ[u][v]
    end

    def has_predecessor?(u, v)
      @pred[u] && @pred[u][v]
    end

    def clear
      @succ.clear
      @pred.clear
      @nodes.clear
      @graph.clear
    end

    def is_directed?
      true
    end

    def to_s
      res = ''
      @adj.each do |u, nbrs|
        nbrs.each do |v, options|
          res = "#{res}#{u}->#{v} #{options}\n"
        end
      end
      res[0...-1]
    end
  end
end
