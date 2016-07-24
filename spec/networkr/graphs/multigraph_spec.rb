require 'spec_helper'

describe Networkr::MultiGraph do
  subject(:g) { Networkr::MultiGraph.new }

  describe "#new_edge_key" do
    it "returns an unused key" do
      expect(g.new_edge_key(1, 2)).to eq(0)
      g.add_edge(1, 2, nil, weight: 10)
      expect(g.new_edge_key(1, 2)).to eq(1)
    end
  end

  describe "#add_edge" do
    it "adds parallel edges" do
      g.add_edge(1, 2, nil, weight: 10)
      g.add_edge(1, 2, nil, weight: 30)
      g.add_edge(2, 3, nil, weight: 20)
      expect(g.adj).to eq({
        1 => {
          2 => {
            0 => { weight: 10 },
            1 => { weight: 30 }
          }
        },
        2 => {
          1 => {
            0 => { weight: 10 },
            1 => { weight: 30 }
          },
          3 => {
            0 => { weight: 20 }
          }
        },
        3 => {
          2 => {
            0 => { weight: 20 }
          }
        }
      })
    end
  end

  describe "#remove_edge" do
    it "removes a single edge" do
      g.add_edge(1, 2, nil, weight: 10)
      g.add_edge(1, 2, nil, weight: 30)
      g.add_edge(2, 3, nil, weight: 20)
      g.remove_edge(1, 2)
      expect(g.adj).to eq({
        1 => {
          2 => {
            1 => { weight: 30 }
          }
        },
        2 => {
          1 => {
            1 => { weight: 30 }
          },
          3 => {
            0 => { weight: 20 }
          }
        },
        3 => {
          2 => {
            0 => { weight: 20 }
          }
        }
      })
    end

    it "removes a specific edge if given key" do
      g.add_edge(1, 2, nil, weight: 10)
      g.add_edge(1, 2, nil, weight: 30)
      g.add_edge(2, 3, nil, weight: 20)
      g.remove_edge(1, 2, 1)
      expect(g.adj).to eq({
        1 => {
          2 => {
            0 => { weight: 10 }
          }
        },
        2 => {
          1 => {
            0 => { weight: 10 }
          },
          3 => {
            0 => { weight: 20 }
          }
        },
        3 => {
          2 => {
            0 => { weight: 20 }
          }
        }
      })
    end

    it "raises an error if edge with key not in graph" do
      g.add_edge(1, 2, nil, weight: 10)
      g.add_edge(1, 2, nil, weight: 30)
      g.add_edge(2, 3, nil, weight: 20)
      expect { g.remove_edge(1, 2, 3) }.to raise_error(NetworkrError)
    end
  end

  describe "#is_multigraph?" do
    it "returns the correct boolean" do
      expect(g.is_multigraph?).to be_truthy
    end
  end
end
