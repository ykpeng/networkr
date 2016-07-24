require 'spec_helper'

describe Networkr do
  describe "::dijkstra" do
    let(:g) { Networkr::Graph.new }

    before(:each) do
      g.add_edge(1, 2, weight: 1)
      g.add_edge(1, 8, weight: 2)
      g.add_edge(2, 3, weight: 1)
      g.add_edge(3, 4, weight: 1)
      g.add_edge(4, 5, weight: 1)
      g.add_edge(5, 6, weight: 1)
      g.add_edge(6, 7, weight: 1)
      g.add_edge(7, 8, weight: 1)
    end

    it "calculates shortest path distances from source" do
      expect(Networkr.dijkstra(g, 1)).to eq({1=>0, 2=>1, 8=>2, 3=>2, 7=>3, 4=>3, 6=>4, 5=>4})
    end
  end
end
