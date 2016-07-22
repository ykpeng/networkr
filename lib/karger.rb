require_relative 'graph.rb'

def kargerMinCut(graph)
  while graph.nodes.length > 2
    node1 = graph.nodes.sample
    node2 = graph.edges[node1].sample
    e = [node1, node2]
    contract(graph, node1, node2)
  end
  graph.edges[graph.nodes[0]].length
end

def contract(graph, node1, node2)
  graph.edges[node2].each do |node|
    graph.edges[node1] << node if node != node1
    graph.edges[node].delete(node2)
    graph.edges[node] << node1 if node != node1
  end
  graph.edges.delete(node2)
end

def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("kargerMinCut.txt")

  split_int_lines = lines.map do |line|
    line.split.map { |char| char.to_i }
  end

  graph = Graph.new

  nodes = {}
  split_int_lines.each do |line|
    node = line[0]
    graph.add_node(node)
    nodes[line[0]] = node
  end

  split_int_lines.each do |line|
    line[1..-1].each do |node_num|
      edge = Edge.new(nodes[line[0]], nodes[node_num])
      graph.add_edge(edge)
    end
  end

  # puts kargerMinCut(graph)
  graph_copy = deep_copy(graph)

  n = graph.nodes.length
  mincut = n
  (n ** 3).times do
    mincut = kargerMinCut(graph_copy) if kargerMinCut(graph_copy) < mincut
  end
  p mincut
end
