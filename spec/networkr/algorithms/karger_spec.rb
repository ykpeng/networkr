require 'spec_helper'

describe Networkr do
  describe "::karger_repeated" do
    let(:g) { Networkr::MultiGraph.new }

    before(:each) do
      g.add_edge(0, 1)
      g.add_edge(0, 3)
      g.add_edge(1, 3)
      g.add_edge(3, 2)
      g.add_edge(2, 0)
    end

    it "computes minimum cut" do
      expect(Networkr.karger_repeated(g)).to eq(2)
    end
  end
end
