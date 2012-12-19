require 'spec_helper'

describe Ship::LoadingVictoryPoints do
  it "returns 0 for no loading actions" do
    described_class.new([]).basic_points.should == 0
  end

  it "returns 1 point per barrel loaded from a loading result" do
    results = [3.barrels_of(:indigo)]
    described_class.new(results).basic_points.should == 3
  end

  it "returns 1 point per barrel loaded from multiple loading results" do
    results = [3.barrels_of(:indigo), 3.barrels_of(:indigo)]
    described_class.new(results).basic_points.should == 6
  end

  describe "when the player is the captain" do
    it "returns 0 if the player hasn't loaded" do
      described_class.new([]).captain_points.should == 0
    end
    
    it "returns 1 extra point if loading has happened" do
      result = [3.barrels_of(:indigo)]
      described_class.new(result).captain_points.should == 1
    end
  end

  describe "with a harbor" do
    it "returns 1 extra point for each loading" do
      results = [3.barrels_of(:indigo), 3.barrels_of(:indigo)]
      described_class.new(results).harbor_points.should == 2
    end
  end

  it "calculates the sum of all points" do
    results = [3.barrels_of(:indigo), 3.barrels_of(:indigo)]
    described_class.new(results).
      calculate(:captain,
                :harbor,
                :harbor).
      should == 6 + 1 + 2 + 2
  end
end
