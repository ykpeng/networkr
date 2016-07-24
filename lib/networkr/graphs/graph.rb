class Graph
=begin
Class for undirected graphs.

A Graph stores nodes and edges with optional attributes.

Graphs hold undirected edges. Self loops are allowed but parallel  edges are not.

Nodes can be arbitrary hashable Ruby objects with optional attributes.

Edges are represented as links between nodes with option attributes.

Parameters
----------
options: attributes to add to graph as key/value pairs, optional (default is {})

See Also
--------
DiGraph

Examples
--------
Create an empty graph with no nodes and edges.

>>> g = Graph()

g can be grown in several ways

**Nodes:**

Add one node at a time:

>>> g.add_node(1)

**Edges:**

Add one edge at a time:

>>> g.add_edge(1, 2)

If some edges connect nodes not yet in the graph, the nodes are added automatically. There are no erros when adding nodes or edges that already exist.

**Attributes:**

Each graph, node, and edge can hold key/value attribute pairs in an associated attribute hash. By default these are empty, but can be added or changed using add_node, add_node, or direct manipulation of the attribute hashes named graph, nodes, and adj.

>>> g = Graph(name: "users")
>>> g.graph
{ name: "users" }

Add/update node attributes using add_node or g.nodes:

>>> g.add_node(1, username: "janedoe")
>>> g.add_node(3, username: "johndoe")
>>> g.nodes[1]
{ username: "janedoe" }
>>> g.nodes[1][:score] = 10
>>> g.nodes[1].delete(:score) # remove attribute
>>> g.nodes
{ 1: { username: "janedoe" }, 3: { username: "johndoe" } }

Add/update edge attributes using add_edge or g.adj:

>>> g.add_edge(1, 2, weight: 10)
>>> g.adj[1][2][:weight] = 4
>>> g.adj[1][2]
{ weight: 4 }

**Representation:**
:TODO
g.to_s

1-2 { weight: 4 }
2-6 { weight: 10 }
4-6 { weight: 8 }
3-5 { weight: 5 }
5-6 { weight: 1 }

=end
  attr_accessor :graph, :nodes, :adj

  def initialize(options = {})
    @graph = options
    @nodes = {}
    @adj = {}
  end

  def add_node(node, options = {})
    if @nodes[node]
      @nodes[node].merge!(options)
    else
      @nodes[node] = options
      @adj[node] = {}
    end
  end

  def remove_node(node)
    if @nodes[node]
      @nodes.delete(node)
    else
      raise "Node #{node} not in graph"
    end

    nbrs = @adj[node]
    nbrs.each_key do |nbr|
      @adj[nbr].delete(node)
    end
    @adj.delete(node)
  end

  def add_edge(u, v, options = {})
    if !@nodes[u]
      @adj[u] = {}
      @nodes[u] = {}
    end
    if !@nodes[v]
      @adj[v] = {}
      @nodes[v] = {}
    end
    data = @adj[u][v] || {}
    data.merge!(options)
    @adj[u][v] = data
    @adj[v][u] = data
  end

  def remove_edge(u, v)
    if @adj[u][v]
      @adj[u].delete(v)
      if u != v
        @adj[v].delete(u)
      end
    else
      raise "Edge #{u}-#{v} not in graph"
    end
  end

  def children_of(node)
    @adj[node]
  end

  def has_node(node)
    @nodes.include?(node)
  end

  def has_edge(u, v)
    @adj[u].includes?(v)
  end

  def length
    @nodes.length
  end

  def clear
    @graph.clear
    @nodes.clear
    @adj.clear
  end

  def deep_copy
    Marshal.load(Marshal.dump(self))
  end

  def is_multigraph?
    false
  end

  def is_directed?
    false
  end

  def to_s
    res = ''
    @adj.each do |u, nbrs|
      nbrs.each do |v, options|
        res = "#{res}#{u}-#{v} #{options}\n"
      end
    end
    res[0...-1]
  end
end
