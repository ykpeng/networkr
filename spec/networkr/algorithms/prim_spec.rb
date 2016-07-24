require 'spec_helper'

describe Networkr do
  describe "::prim" do
    let(:g) { Networkr::Graph.new }

    before(:each) do
      g.add_edge(8, 9, weight: 3)
      g.add_edge(1, 2, weight: 2)
      g.add_edge(2, 3, weight: 4)
      g.add_edge(2, 4, weight: 2)
      g.add_edge(3, 4, weight: 3)
      g.add_edge(4, 5, weight: 5)
      g.add_edge(4, 6, weight: 3)
      g.add_edge(5, 6, weight: 3)
      g.add_edge(6, 7, weight: 5)
      g.add_edge(6, 8, weight: 4)
      g.add_edge(5, 8, weight: 4)
      g.add_edge(7, 9, weight: 2)
      g.add_edge(7, 1, weight: 4)
      g.add_edge(7, 2, weight: 6)
    end

    it "returns minimum spanning tree" do
      length = g.length
      expect(Networkr.prim(g, 1).adj).to eq({
        1 => { 2 => { weight: 2 }, 7 => { weight: 4 } },
        2 => { 1 => { weight: 2 }, 4 => { weight: 2 } },
        4 => { 2 => { weight: 2 }, 3 => { weight: 3 }, 6 => { weight: 3 } },
        3 => { 4 => { weight: 3 } },
        6 => { 4 => { weight: 3 }, 5 => { weight: 3 } },
        5 => { 6 => { weight: 3 } },
        7 => { 1 => { weight: 4 }, 9 => { weight: 2 } },
        9 => { 7 => { weight: 2 }, 8 => { weight: 3 } },
        8 => { 9 => { weight: 3 } }
      })
    end
  end
end
