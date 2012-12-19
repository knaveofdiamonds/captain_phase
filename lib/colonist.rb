require 'immutable_struct'
require 'hamster'
require 'colonist/barrel'
require 'colonist/ship'

def create_ships(number_of_players)
  smallest = number_of_players + 1
  largest  = number_of_players + 3
  (smallest..largest).map {|i| Ship.new(i) }
end

def empty_full_ships(ships)
  ships.map do |ship|
    ship.full? ? Ship.new(ship.spaces) : ship
  end
end

def number_of_barrels(barrels)
  barrels.map(&:quantity).inject(:+) || 0
end

def valid_number_of_barrels_to_retain?(barrels, wharf_spaces=0)
  barrels.size <= wharf_spaces || number_of_barrels(barrels) <= 1
end
