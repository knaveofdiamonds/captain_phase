class Ship
  def self.victory_points(*args)
    LoadingVictoryPoints.new(*args).calculate
  end

  def self.outcomes(ships, barrels)
    LoadingOutcomes.new(ships, barrels).outcomes
  end

  class LoadingResult < ImmutableStruct.new(:ship, :loaded_barrels, :remaining_barrels)
    include Comparable

    def <=>(other)
      loaded_barrels <=> other.loaded_barrels
    end
  end

  class LoadingVictoryPoints
    CAPTAIN_BONUS = 1
  
    attr_reader :barrels
    
    def initialize(*barrels)
      @barrels = barrels.flatten
    end
    
    def calculate(*method_names)
      method_names.unshift :basic
      method_names.map {|m| method("#{m}_points".to_sym).call }.inject(:+)
    end
    
    def basic_points
      number_of_barrels(barrels)
    end
    
    def captain_points
      barrels.empty? ? 0 : CAPTAIN_BONUS
    end
    
    def harbor_points
      barrels.size
    end
  end

  class LoadingOutcomes
    attr_reader :outcomes

    def initialize(ships, barrels)
      @outcomes = ships.product(barrels).map do |(ship, barrel)| 
        ship.load(barrel)
      end.select {|result| valid_result?(result) }
    end

    def possible_to_load?
      ! outcomes.empty?
    end

    private

    def valid_result?(result)
      !result.kind_of?(Symbol)
    end
  end

  attr_reader :spaces, :barrels

  def initialize(spaces, barrels=nil)
    @spaces  = spaces
    @barrels = barrels
    @number_of_barrels = barrels.nil? ? 0 : barrels.quantity
  end

  def free_spaces
    @spaces - @number_of_barrels
  end

  def full?
    free_spaces == 0
  end

  def accepting?(load_barrels)
    @barrels.nil? || @barrels.same_type?(load_barrels)
  end

  def load(barrels)
    return :wrong_goods unless accepting?(barrels)
    return :full_ship if full?

    LoadingResult.new(add_barrels(barrels_to_load(barrels)),
                      barrels_to_load(barrels),
                      remaining_barrels(barrels))
  end

  private

  def barrels_to_load(load_barrels)
    load_barrels.fit_in_space?(free_spaces) ? load_barrels : free_spaces.barrels_of(load_barrels.goods_type)
  end

  def remaining_barrels(load_barrels)
    load_barrels.fit_in_space?(free_spaces) ? load_barrels.zero : load_barrels.decrement(free_spaces)
  end

  def add_barrels(new_barrels)
    Ship.new(@spaces, new_barrels.increment(@number_of_barrels))
  end
end
