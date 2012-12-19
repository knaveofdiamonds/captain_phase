require "spec_helper"

class LoadingOutcomes
  attr_reader :outcomes

  def initialize(ships, barrels)
    @outcomes = ships.product(barrels).map do |(ship, barrel)| 
      ship.load(barrel)
    end
  end

  def possible_to_load?
    outcomes.any? {|r| valid_result?(r) }
  end

  private

  def valid_result?(result)
    !result.kind_of?(Symbol)
  end
end

describe "Can a player load goods" do
  specify "if there is free space, then yes" do
    barrels = [1.barrel_of(:indigo)]
    ships = [Ship.new(4)]
    
    Ship::LoadingOutcomes.new(ships, barrels).should be_possible_to_load
  end
end
