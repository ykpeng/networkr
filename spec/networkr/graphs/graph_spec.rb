require 'spec_helper'

describe Networkr::Graph do
  subject(:g) { Networkr::Graph.new(name: "students") }

  describe "#add_node" do
    it "adds nodes" do
      g.add_node(1, name: "peter")
      g.add_node(2, name: "heather")
      expect(g.nodes).to eq({
        1 => { name: "peter"},
        2 => { name: "heather"}
      })
    end
  end

  describe "#add_edge" do
    it "adds edges" do
      g.add_edge(1, 2, weight: 10)
      g.add_edge(2, 3, weight: 20)
      expect(g.adj).to eq({
        1 => { 2 => { weight: 10}},
        2 => { 1 => { weight: 10}, 3 => { weight: 20}},
        3 => { 2 => { weight: 20}}
      })
    end
  end

  describe "#remove_node" do
    it "removes nodes" do
      g.add_node(1, name: "peter")
      g.add_node(2, name: "heather")
      g.remove_node(2)
      expect(g.nodes).to eq({
        1 => { name: "peter"}
      })
    end

    it "raises an error if node not in graph" do
      g.add_node(1, name: "peter")
      expect { g.remove_node(2) }.to raise_error(NetworkrError)
    end
  end

  describe "#remove_edge" do
    it "removes edge" do
      g.add_edge(1, 2, weight: 10)
      g.add_edge(2, 3, weight: 20)
      g.remove_edge(2, 3)
      expect(g.adj).to eq({
        1 => { 2 => { weight: 10}},
        2 => { 1 => { weight: 10}},
        3 => {}
      })
    end

    it "raises an error if edge not in graph" do
      g.add_edge(1, 2, weight: 10)
      expect { g.remove_edge(2, 3) }.to raise_error(NetworkrError)
    end
  end

  describe "#children_of" do
    it "returns children of node" do
      g.add_edge(1, 2, weight: 10)
      g.add_edge(1, 3, weight: 20)
      expect(g.children_of(1)).to eq({
        2 => { weight: 10 },
        3 => { weight: 20 }
      })
    end
  end

  describe "#has_node?" do
    it "returns the correct boolean" do
      g.add_node(1, name: "peter")
      expect(g).to have_node(1)
      expect(g).not_to have_node(2)
    end
  end

  describe "#has_edge?" do
    it "returns the correct boolean" do
      g.add_edge(1, 2, weight: 10)
      expect(g).to have_edge(1, 2)
      expect(g).not_to have_edge(2, 3)
    end
  end

  describe "#length" do
    it "returns the number of nodes in the graph" do
      g.add_node(1, name: "peter")
      g.add_node(2, name: "heather")
      expect(g.length).to eq(2)
    end
  end

  describe "#clear" do
    it "clears the graph" do
      g.add_node(1, name: "peter")
      g.add_node(2, name: "heather")
      g.add_edge(1, 2, weight: 10)
      g.clear
      expect(g.graph).to be_empty
      expect(g.nodes).to be_empty
      expect(g.adj).to be_empty
    end
  end

  describe "#deep_copy" do
    it "returns a deep copy of graph" do
      g.add_edge(1, 2, weight: 10)
      g.add_edge(2, 3, weight: 20)
      deep_copy = g.deep_copy
      deep_copy.add_edge(3, 4, weight: 40)
      expect(deep_copy.adj).to eq({
        1 => { 2 => { weight: 10}},
        2 => { 1 => { weight: 10}, 3 => { weight: 20}},
        3 => { 2 => { weight: 20}, 4 => { weight: 40}},
        4 => { 3 => { weight: 40}}
      })
      expect(g.adj).to eq({
        1 => { 2 => { weight: 10}},
        2 => { 1 => { weight: 10}, 3 => { weight: 20}},
        3 => { 2 => { weight: 20}}
      })
    end
  end

  describe "#is_multigraph?" do
    it "returns the correct boolean" do
      expect(g.is_multigraph?).to be_falsey
    end
  end

  describe "#is_directed?" do
    it "returns the correct boolean" do
      expect(g.is_directed?).to be_falsey
    end
  end
end
