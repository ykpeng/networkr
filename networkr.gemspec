Gem::Specification.new do |s|
  s.name        = 'networkr'
  s.version     = '0.0.0'
  s.date        = '2016-07-23'
  s.summary     = "NetworkR"
  s.description = "A gem for creating and manipulating graphs in Ruby"
  s.authors     = ["Yi-Ke Peng"]
  s.email       = 'yi.ke.peng@gmail.com'
  s.files       = [
    "lib/networkr.rb", "lib/networkr/graphs/graph.rb",
    "lib/networkr/graphs/digraph.rb",
    "lib/networkr/graphs/multigraph.rb",
    "lib/networkr/algorithms/dijkstra.rb",
    "lib/networkr/algorithms/karger.rb",
    "lib/networkr/algorithms/kosaraju.rb",
    "lib/networkr/algorithms/prim.rb",
    "lib/utils/heap.rb",
    "spec/algorithms/dijkstra_spec.rb"
  ]
  s.homepage    =
    'http://rubygems.org/gems/networkr'
  s.license       = 'MIT'
end
