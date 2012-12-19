require 'spec_helper'

describe "Retaining barrels at the end of a round" do
  specify "retaining no barrels is allowed" do
    valid_number_of_barrels_to_retain?([]).should be_true
  end

  specify "retaining 1 barrel is allowed" do
    valid_number_of_barrels_to_retain?([1.barrel_of(:indigo)]).should be_true
  end

  specify "retaining 2 barrels is not normally allowed" do
    valid_number_of_barrels_to_retain?([2.barrels_of(:indigo)]).
      should be_false

    barrels = [1.barrel_of(:indigo), 1.barrel_of(:coffee)]
    valid_number_of_barrels_to_retain?(barrels).should be_false
  end

  specify "retaining as many barrels of 1 type in 1 warehouse space is allowed" do
    valid_number_of_barrels_to_retain?([4.barrels_of(:indigo)], 1).
      should be_true
  end

  specify "only barrels of 1 type in 1 warehouse space is allowed" do
    barrels = [1.barrel_of(:indigo), 1.barrel_of(:coffee)]
    valid_number_of_barrels_to_retain?(barrels, 1).should be_false
  end
end
