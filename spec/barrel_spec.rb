require 'spec_helper'

describe Barrel do
  it "has a quantity" do
    5.barrels_of(:indigo).quantity.should == 5
  end

  it "has a goods type" do
    5.barrels_of(:indigo).goods_type.should == :indigo
  end

  it "is a value object" do
    5.barrels_of(:indigo).should == 5.barrels_of(:indigo)
  end

  it "can be added" do
    (5.barrels_of(:indigo) + 1.barrel_of(:indigo)).should == 6.barrels_of(:indigo)
  end

  it "can only be added to the same type of goods" do
    expect {
      5.barrels_of(:indigo) + 1.barrel_of(:coffee)
    }.to raise_error(Barrel::GoodsTypeMismatch)
  end

  it "can be subtracted" do
    (5.barrels_of(:indigo) - 1.barrel_of(:indigo)).should == 4.barrels_of(:indigo)
  end

  it "can only be subtracted from the same type of goods" do
    expect {
      5.barrels_of(:indigo) - 1.barrel_of(:coffee)
    }.to raise_error(Barrel::GoodsTypeMismatch)
  end

  it "can be incremented" do
    5.barrels_of(:indigo).increment(3).should == 8.barrels_of(:indigo)
  end

  it "can be decremented" do
    5.barrels_of(:indigo).decrement(3).should == 2.barrels_of(:indigo)
  end

  it "is comparable, cross type" do
    [3.barrels_of(:indigo), 1.barrel_of(:coffee), 4.barrels_of(:sugar)].sort.
      should == [1.barrel_of(:coffee), 3.barrels_of(:indigo), 4.barrels_of(:sugar)]
  end

  it "can fit in space" do
    3.barrels_of(:indigo).fit_in_space?(3).should == true
    3.barrels_of(:indigo).fit_in_space?(2).should == false
  end

  it "can be zero" do
    0.barrels_of(:indigo).should be_zero
  end
end
