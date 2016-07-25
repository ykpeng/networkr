module Networkr

  # Class for undirected graphs that can store parallel edges.
  #
  # A MultiGraph holds undirected edges. Self loops are allowed.
  #
  # See Also
  # --------
  # Graph
  # DiGraph
  class MultiGraph < Graph

    # returns an unused key for edges between nodes 'u' and 'v'.
    #
    # The nodes 'u' and 'v' do not need to be already in the graph.
    #
    # Notes
    # -----
    # The new key is the number of existing edges between 'u' and 'v', increased if necessary to ensure uniqueness. The first edge will have key 0, the second edge 1, etc. If an edge is removed, new keys may not be in this order.
    #
    # Parameters
    # ----------
    # u, v: nodes
    #
    # Returns
    # -------
    # key: int
    def new_edge_key(u, v)
      if @adj[u] && @adj[u][v]
        keys = @adj[u][v]
        key = keys.length
        while keys.include?(key)
          key += 1
        end
        return key
      else
        return 0
      end
    end

    def add_edge(u, v, key=nil, options={})
      if !@adj.include?(u)
        @adj[u] = {}
        @nodes[u] = {}
      end
      if !@adj.include?(v)
        @adj[v] = {}
        @nodes[v] = {}
      end
      if !key
        key = new_edge_key(u, v)
      end
      if @adj[u].include?(v)
        keys = @adj[u][v]
        data = keys[key] || {}
        data.merge!(options)
        keys[key] = data
      else
        data = options
        keys = {}
        keys[key] = data
        @adj[u][v] = keys
        @adj[v][u] = keys
      end
      key
    end

    def remove_edge(u, v, key=nil)
      keys = @adj[u][v]
      if keys
        if !key
          keys.shift
        else
          if keys[key]
            keys.delete(key)
          else
            raise NetworkrError, "Edge #{u}-#{v} with key #{key} not in graph"
          end
        end
        if keys.length == 0
          @adj[v].delete(v)
          if u != v
            @adj[v].delete(u)
          end
        end
      else
        raise NetworkrError, "Edge #{u}-#{v} not in graph"
      end
    end

    def is_multigraph?
      true
    end
  end
end
