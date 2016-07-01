###############################################################################
# This class holds name and base price of product.
# Available public methods:
# name => return name of product as String
# price => return price of product as Float
###############################################################################
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
