require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

def load_ship(ship, barrels, goods)
  if will_accept_goods?(ship, goods)
    raise "Cannot load a different type of goods onto a partially loaded ship"
  end

  if full?(ship)
    raise "Cannot load a fully loaded ship"
  end

  new_barrels = ship[:barrels] + barrels_to_load(ship, barrels)

  [ship.merge(:goods => goods, :barrels => new_barrels), 
   remaining_barrels(ship, barrels)]
end

def full?(ship)
  free_spaces(ship) == 0
end

def will_accept_goods?(ship, goods)
  ship[:goods] && ship[:goods] != goods
end

def free_spaces(ship)
  ship[:spaces] - ship[:barrels]
end

def barrels_to_load(ship, barrels)
  spaces = free_spaces(ship)
  barrels > spaces ? spaces : barrels
end

def remaining_barrels(ship, barrels)
  spaces = free_spaces(ship)
  barrels > spaces ? barrels - spaces : 0
end

describe "Loading a ship" do
  it "loads all barrels onto an empty ship" do
    ship = {:spaces => 5, :barrels => 0}
    ship, remaining_barrels = load_ship(ship, 1, :indigo)
    
    ship[:barrels].should == 1
    remaining_barrels.should == 0
  end

  it "loads all barrels possible onto an empty ship" do
    ship = {:spaces => 5, :barrels => 0}
    ship, remaining_barrels = load_ship(ship, 7, :indigo)
    
    ship[:barrels].should == 5
    remaining_barrels.should == 2
  end

  it "loads all barrels possible onto a partially full ship" do
    ship = {:spaces => 5, :barrels => 3}
    ship, remaining_barrels = load_ship(ship, 7, :indigo)
    
    ship[:barrels].should == 5
    remaining_barrels.should == 5
  end

  it "raises an error if you try and load the wrong type of goods" do
    ship = {:spaces => 5, :barrels => 3, :goods => :coffee}
    expect { load_ship(ship, 7, :indigo) }.to raise_error
  end

  it "raises an error if you try and load a full ship" do
    ship = {:spaces => 5, :barrels => 5, :goods => :indigo}
    expect { load_ship(ship, 1, :indigo) }.to raise_error
  end
end
