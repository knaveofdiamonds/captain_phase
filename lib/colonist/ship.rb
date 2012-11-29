class Ship
  class LoadingResult < ImmutableStruct.new(:ship, :loaded_barrels, :remaining_barrels)
  end
  
  attr_reader :spaces, :barrels, :goods

  def initialize(spaces, args={})
    @spaces  = spaces
    @barrels = args[:barrels] || 0
    @goods   = args[:goods]
    @id      = args[:id] || object_id
  end

  def free_spaces
    spaces - barrels
  end

  def full?
    free_spaces == 0
  end

  def accepting?(goods_to_load)
    @goods.nil? || @goods == goods_to_load
  end

  def barrels_to_load(number_of_barrels)
    number_of_barrels > free_spaces ? free_spaces : number_of_barrels
  end

  def remaining_barrels(number_of_barrels)
    number_of_barrels > free_spaces ? number_of_barrels - free_spaces : 0
  end

  def load(barrels, load_goods)
    return :wrong_goods unless accepting?(load_goods)
    return :full_ship if full?

    LoadingResult.new(add_barrels(barrels_to_load(barrels), load_goods),
                      barrels_to_load(barrels),
                      remaining_barrels(barrels))
  end

  private

  def add_barrels(new_barrels, load_goods)
    self.class.new(@spaces, 
                   :goods => load_goods, 
                   :barrels => @barrels + new_barrels)
  end
end
