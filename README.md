# Networkr

Networkr is a Ruby gem inspired by the Python package NetworkX. It includes basic functionality for the creation, manipulation, and analysis of graphs.

Graphs supported include undirected single-edge graphs (weighted or unweighted), directed single-edge graphs (weighted or unweighted), and undirected multi-edge graphs (weighted or unweighted).

Algorithms available include Dijkstra's shortest paths, Karger's minimum cut, Kosaraju's strongly connected components, and Prim's minimum spanning tree.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'networkr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install networkr

## Usage

### Graphs

All `Networkr` graphs store nodes, an adjacency list, and optional attributes.

- `Networkr::Graph` is the base class for `Networkr::DiGraph` and `Networkr::MultiGraph`. `Networkr::Graph` graphs hold undirected edges. Self loops are allowed but parallel edges are not.

- `Networkr::DiGraph` graphs hold directed edges. Self loops are allowed but parallel edges are not.

- `Networkr::MultiGraph` graphs hold undirected edges. Self loops and parallel edges are allowed.

**Graphs**

Create an empty `Networkr::Graph`:

```ruby
g = Networkr::Graph.new
```

Create an empty `Networkr::Graph` with an attribute:
```ruby
g = Networkr::Graph.new(name: "users")
g.graph
{ name: "users" }
```

`Networkr` graphs can be grown in several ways.

**Nodes**

Nodes can be any Ruby object and can hold optional attributes.

Add a node:

```ruby
g.add_node(1)
```

Add nodes with an attributes:

```ruby
g.add_node(1, username: "janedoe")
g.add_node(3, username: "johndoe")
g.nodes[1]
{ username: "janedoe" }
```

Add/update node attributes using `#add_node` or `g.nodes`:

```ruby
g.nodes[1][:score] = 10
g.nodes[1].delete(:score) # remove attribute
g.nodes
{ 1 => { username: "janedoe" }, 3 => { username: "johndoe" } }
```

**Edges**

Edges are represented in an adjacency list can also hold optional attributes. If an edge connects nodes not yet in the graph, the nodes are added automatically. There are no errors when adding nodes or edges that already exist.

Add an edge:

```ruby
g.add_edge(1, 2)
```

Add/update edge attributes using `#add_edge` or `g.adj`:

```ruby
g.add_edge(1, 2, weight: 10)
g.adj[1][2][:weight] = 4
g.adj[1][2]
{ weight: 4 }
```

Other methods that can be called on `Networkr` graphs:

- `#remove_edge(u, v)` removes edge `u`-`v`

- `#children_of(node)` returns hash containing children of `node`

- `#has_node?(node)` returns `true` if graph contains node `node`

- `#has_edge?(u, v)` returns `true` if graph contains edge `u`-`v`

- `#length` returns number of nodes in graph

- `#clear` clears graph

- `#deep_copy` returns deep copy of graph

- `#is_directed?` returns boolean

- `#is_multigraph?` returns boolean

- `#to_s` returns string representation of graph

### Algorithms

**Shortest Paths**

`Networkr::dijkstra` computes the shortest paths to every node in a weighted, undirected graph from a single source node. Weights must be non-negative.

```ruby
g = Networkr::Graph.new
...
Networkr::dijkstra(g, source_node) #returns a hash where keys are destination nodes and values are distances
```

**Minimum Spanning Tree**

`Networkr::prim` finds the minimum spanning tree of a weighted, undirected graph. Weights can be negative. `source_node` should be a random node in the graph.

```ruby
g = Networkr::Graph.new
...
Networkr::prim(g, source_node) #returns a Networkr::Graph graph
```

**Minimum Cut**

`Networkr::karger` finds a cut that crosses the minimum number of edges in a connected multi-edge graph. Karger's algorithm is a random algorithm and is not guaranteed to generate the correct output. However, if run |V|^2 log |V| times, its success probability is very high.

Use `Networkr::karger` to run the algorithm once. Use `Networkr::karger_repeated` to run it |V|^2 log |V| times.

```ruby
g = Networkr::MultiGraph.new
...
Networkr::karger_repeated(g) #returns the minimum number of edges crossed by a cut
```

**Strongly Connected Components**

`Networkr::kosaraju_scc_sizes` and `Networkr::kosaraju_num_scc` find the strongly connected components in a directed graph.

```ruby
g = Networkr::DiGraph.new
g_rev = Networkr::DiGraph.new #reversed graph of g
...
Networkr::kosaraju_scc_sizes(g, g_rev) #returns the sizes of strongly connected components in descending order
Neworkr::kosaraju_num_scc(g, g_rev) #returns the number of strongly connected components
```

## Future Directions

- Implement algorithms with more efficient data structures
- Add more robust tests
- Allow algorithms to take more than one kind of graph and produce more than one kind of result
- Add more algorithms

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ykpeng/networkr.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
