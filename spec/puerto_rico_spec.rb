require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Loading a ship" do
  it "loads all barrels onto an empty ship" do
    ship = Ship.new(5)
    result = ship.load(1, :indigo)
    
    result.ship.barrels.should == 1
    result.remaining_barrels.should == 0
  end

  it "loads all barrels possible onto an empty ship" do
    ship = Ship.new(5)
    result = ship.load(7, :indigo)
    
    result.ship.barrels.should == 5
    result.remaining_barrels.should == 2
  end

  it "loads all barrels possible onto a partially full ship" do
    ship = Ship.new(5, :barrels => 3, :goods => :indigo)
    result = ship.load(7, :indigo)
    
    result.ship.barrels.should == 5
    result.remaining_barrels.should == 5
  end

  it "returns an error if you try and load the wrong type of goods" do
    ship = Ship.new(5, :barrels => 3, :goods => :coffee)
    ship.load(7, :indigo).should == :wrong_goods
  end

  it "returns an error if you try and load a full ship" do
    ship = Ship.new(5, :barrels => 5, :goods => :indigo)
    ship.load(1, :indigo).should == :full_ship
  end
end
