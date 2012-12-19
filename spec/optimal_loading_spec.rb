require 'spec_helper'

describe "Optimizing loading to produce the largest VP differential" do

  it "produces the largest point difference" do
    players = [[3.barrels_of(:indigo), 2.barrels_of(:corn)], []]
    ships = [Ship.new(4)]

    
    result = Ship.outcomes(ships, players.first).max
    players = players.rotate
    ships = ships.map {|s| s.spaces == result.ship.spaces ? result.ship : s }

    result.loaded_barrels.should == 3.barrels_of(:indigo)
    ships.first.free_spaces.should == 1
    players.first.should == []
  end
end
