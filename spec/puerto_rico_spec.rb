require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Loading a ship" do
  it "loads all barrels onto an empty ship" do
    ship = Ship.new(5)
    result = ship.load(1.barrel_of(:indigo))
    
    result.ship.barrels.should == 1.barrel_of(:indigo)
    result.remaining_barrels.should == 0.barrels_of(:indigo)
  end

  it "loads all barrels possible onto an empty ship" do
    ship = Ship.new(5)
    result = ship.load(7.barrels_of(:indigo))
    
    result.ship.barrels.should == 5.barrels_of(:indigo)
    result.remaining_barrels.should == 2.barrels_of(:indigo)
  end

  it "loads all barrels possible onto a partially full ship" do
    ship = Ship.new(5, 3.barrels_of(:indigo))
    result = ship.load(7.barrels_of(:indigo))
    
    result.ship.barrels.should == 5.barrels_of(:indigo)
    result.remaining_barrels.should == 5.barrels_of(:indigo)
  end

  it "returns an error if you try and load the wrong type of goods" do
    ship = Ship.new(5, 3.barrels_of(:coffee))
    ship.load(7.barrels_of(:indigo)).should == :wrong_goods
  end

  it "returns an error if you try and load a full ship" do
    ship = Ship.new(5, 5.barrels_of(:indigo))
    ship.load(1.barrel_of(:indigo)).should == :full_ship
  end
end
