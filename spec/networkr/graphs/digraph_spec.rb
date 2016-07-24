require 'spec_helper'

describe Networkr::DiGraph do
  subject(:g) { Networkr::DiGraph.new(name: "students") }

  describe "#add_node" do
    it "adds nodes" do
      g.add_node(1, name: "peter")
      g.add_node(2, name: "heather")
      expect(g.succ[1]).to be_empty
      expect(g.pred[1]).to be_empty
      expect(g.nodes[1]).to eq({ name: "peter" })
      expect(g.nodes[2]).to eq({ name: "heather" })
    end
  end

  describe "#remove_node" do
    it "removes nodes" do
      g.add_node(1, name: "peter")
      g.add_node(2, name: "heather")
      g.add_node(3, name: "sam")
      g.add_edge(1, 2, weight: 10)
      g.add_edge(2, 3, weight: 20)
      g.remove_node(2)
      expect(g.nodes).to eq({
        1 => { name: "peter"},
        3 => { name: "sam" }
      })
      expect(g.succ[1]).to be_empty
      expect(g.pred[3]).to be_empty
      expect(g.succ[2]).to be_nil
      expect(g.pred[2]).to be_nil
    end
  end

  describe "#add_edge" do
    it "adds edges" do
      g.add_edge(1, 2, weight: 10)
      g.add_edge(2, 3, weight: 20)
      expect(g.succ).to eq({
        1 => { 2 => { weight: 10}},
        2 => { 3 => { weight: 20}},
        3 => {}
      })
      expect(g.pred).to eq({
        1 => {},
        2 => { 1 => { weight: 10}},
        3 => { 2 => { weight: 20}}
      })
    end
  end

  describe "#remove_edge" do
    it "removes edges" do
      g.add_edge(1, 2, weight: 10)
      g.add_edge(2, 3, weight: 20)
      g.remove_edge(2, 3)
      expect(g.succ).to eq({
        1 => { 2 => { weight: 10}},
        2 => {},
        3 => {}
      })
      expect(g.pred).to eq({
        1 => {},
        2 => { 1 => { weight: 10}},
        3 => {}
      })
    end
  end

  describe "#has_successor?" do
    it "returns the correct boolean" do
      g.add_edge(1, 2, weight: 10)
      expect(g.has_successor?(1, 2)).to be_truthy
    end
  end

  describe "#has_predecessor?" do
    it "returns the correct boolean" do
      g.add_edge(1, 2, weight: 10)
      expect(g.has_predecessor?(2, 1)).to be_truthy
    end
  end

  describe "#clear" do
    it "clears the graph" do
      g.add_edge(1, 2, weight: 10)
      g.add_edge(2, 3, weight: 20)
      g.clear
      expect(g.succ).to be_empty
      expect(g.pred).to be_empty
      expect(g.nodes).to be_empty
      expect(g.graph).to be_empty
    end
  end
  describe "#is_directed?" do
    it "returns the correct boolean" do
      expect(g.is_directed?).to be_truthy
    end
  end
end
