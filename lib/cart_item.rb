###############################################################################
# This class holds product (must respond to '#name' and '#price') and quantity.
# Available public methods:
# #product => return Product instance.
# #tax => return as Float (rounded to 2 decimal places).
# #quantity => return number of ordered products as Integer (default 1).
# #name => return name of the product as String.
# #tax => return:
#   - 10% from product price (except books, food, and medical products);
#   - 0.0 for books, food, and medical products;
#   - additional 5% for all imported products.
#   As Float (rounded to the nearest 0.05).
# #price => return price of the product (including tax)
#           as Float (rounded to 2 decimal places).
# #to_s => return string representation of self as String.
###############################################################################
class CartItem
  attr_reader :product, :quantity

  TAX_FREE_CATEGORIES = %w(book chocolate pills).freeze

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
  end

  def tax
    round_tax(product.price * (basic_tax_rate + import_tax_rate) / 100.0)
  end

  def price
    (product.price + tax).round(2)
  end

  def name
    product.name
  end

  def to_s
    "#{quantity}, #{product.name}, #{price}"
  end

  private

  def basic_tax_rate
    product.name =~ Regexp.new(TAX_FREE_CATEGORIES.join('|')) ? 0 : 10
  end

  def import_tax_rate
    product.name =~ /imported/ ? 5 : 0
  end

  def round_tax(value)
    (value * 20).round / 20.0
  end
end
