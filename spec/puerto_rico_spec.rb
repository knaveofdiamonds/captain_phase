require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Ship
  attr_reader :spaces, :barrels, :goods

  def initialize(args)
    @spaces  = args[:spaces]
    @barrels = args[:barrels] || 0
    @goods   = args[:goods]
  end

  def free_spaces
    spaces - barrels
  end

  def full?
    free_spaces == 0
  end

  def accepting?(goods)
    @goods.nil? || @goods == goods
  end

  def barrels_to_load(number_of_barrels)
    number_of_barrels > free_spaces ? free_spaces : number_of_barrels
  end

  def remaining_barrels(number_of_barrels)
    number_of_barrels > free_spaces ? number_of_barrels - free_spaces : 0
  end

  def load(barrels, load_goods)
    return :wrong_goods unless accepting?(goods)
    return :full_ship if full?

    [add_barrels(barrels_to_load(barrels), load_goods),
     remaining_barrels(barrels)]
  end

  private

  def add_barrels(new_barrels, load_goods)
    self.class.new(:spaces => @spaces, 
                   :goods => load_goods, 
                   :barrels => @barrels + new_barrels)
  end
end

describe "Loading a ship" do
  it "loads all barrels onto an empty ship" do
    ship = Ship.new(:spaces => 5)
    ship, remaining_barrels = ship.load(1, :indigo)
    
    ship.barrels.should == 1
    remaining_barrels.should == 0
  end

  it "loads all barrels possible onto an empty ship" do
    ship = Ship.new(:spaces => 5)
    ship, remaining_barrels = ship.load(7, :indigo)
    
    ship.barrels.should == 5
    remaining_barrels.should == 2
  end

  it "loads all barrels possible onto a partially full ship" do
    ship = Ship.new(:spaces => 5, :barrels => 3, :goods => :indigo)
    ship, remaining_barrels = ship.load(7, :indigo)
    
    ship.barrels.should == 5
    remaining_barrels.should == 5
  end

  it "returns an error if you try and load the wrong type of goods" do
    ship = Ship.new(:spaces => 5, :barrels => 3, :goods => :coffee)
    ship.load(7, :indigo).should == :wrong_goods
  end

  it "returns an error if you try and load a full ship" do
    ship = Ship.new(:spaces => 5, :barrels => 5, :goods => :indigo)
    ship.load(1, :indigo).should == :full_ship
  end
end
