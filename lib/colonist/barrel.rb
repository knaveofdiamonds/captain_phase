class Barrel < ImmutableStruct.new(:quantity, :goods_type)
  include Comparable
  
  class GoodsTypeMismatch < RuntimeError
  end

  def <=>(other)
    quantity <=> other.quantity
  end
  
  def +(other)
    unless same_type?(other)
      raise GoodsTypeMismatch.new("Cannot add barrels of #{other.goods_type} to barrels of #{goods_type}")
    end
    
    self.class.new(quantity + other.quantity, goods_type)
  end

  def -(other)
    unless same_type?(other)
      raise GoodsTypeMismatch.new("Cannot subtract barrels of #{other.goods_type} from barrels of #{goods_type}")
    end

    self.class.new(quantity - other.quantity, goods_type)
  end

  def increment(num)
    self.class.new(quantity + num, goods_type)
  end

  def decrement(num)
    self.class.new(quantity - num, goods_type)
  end

  def fit_in_space?(space)
    quantity <= space
  end

  def zero?
    quantity.zero?
  end

  def zero
    self.class.new(0, goods_type)
  end

  def same_type?(barrels)
    barrels.goods_type == goods_type
  end
end

module BarrelFactoryMethods
  def barrels_of(goods_type)
    Barrel.new(self, goods_type)
  end
  alias :barrel_of :barrels_of  
end

class Integer
  include BarrelFactoryMethods
end
