require 'spec_helper'

describe Networkr do
  describe "::kosaraju" do
    let(:g) { Networkr::DiGraph.new }
    let(:g_rev) { Networkr::DiGraph.new }
    let(:tracker1) { Networkr::Tracker.new }
    let(:tracker2) { Networkr::Tracker.new }

    before(:each) do
      g.add_edge(1, 2)
      g.add_edge(1, 3)
      g.add_edge(1, 4)
      g.add_edge(2, 3)
      g.add_edge(3, 4)
    end

    before(:each) do
      g_rev.add_edge(2, 1)
      g_rev.add_edge(3, 1)
      g_rev.add_edge(4, 1)
      g_rev.add_edge(3, 2)
      g_rev.add_edge(4, 3)
    end

    it "returns sizes of strongly connected components in descending order" do
      expect(Networkr.kosaraju(g, g_rev, tracker1, tracker2)).to eq([1, 1, 1, 1])
    end
  end
end
