require 'spec_helper'

describe "emptying ships" do
  it "returns an array of ships - full ships become empty" do
    ships = [Ship.new(5),
             Ship.new(6, 6.barrels_of(:indigo)),
             Ship.new(7, 3.barrels_of(:indigo))]
    empty_full_ships(ships).map(&:free_spaces).should == [5,6,4]
  end
end

describe "setting up ships" do
  it "has ships of size 4, 5 & 6 with 3 players" do
    create_ships(3).map {|s| s.spaces }.should == [4,5,6]
  end

  it "has ships of size 5, 6 & 7 with 4 players" do
    create_ships(4).map {|s| s.spaces }.should == [5,6,7]
  end

  it "has ships of size 6, 7 & 8 with 5 players" do
    create_ships(5).map {|s| s.spaces }.should == [6,7,8]
  end
end
