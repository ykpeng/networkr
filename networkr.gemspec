# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'networkr/version'

Gem::Specification.new do |spec|
  spec.name          = "networkr"
  spec.version       = Networkr::VERSION
  spec.authors       = ["Yi-Ke Peng"]
  spec.email         = ["yi.ke.peng@gmail.com"]

  spec.summary       = %q{Create and manipulate graphs}
  spec.description   = %q{Networkr is a Ruby gem inspired by the Python package NetworkX. It includes basic functionality for the creation, manipulation, and analysis of graphs.

  Graphs supported include undirected single-edge graphs (weighted or unweighted), directed single-edge graphs (weighted or unweighted), and undirected multi-edge graphs (weighted or unweighted).

  Algorithms available include Dijkstra's shortest paths, Karger's minimum cut, Kosaraju's strongly connected components, and Prim's minimum spanning tree.}
  spec.homepage      = "http://github.com/ykpeng/networkr"
  spec.license       = "MIT"
  spec.metadata["yard.run"] = "yri" # use "yard" to build full HTML docs.

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
