###############################################################################
# This class holds collection of items that have 'price' and 'tax' attributes.
# Available public methods:
# #total => return sum of items prices (including tax)
#           as Float (rounded to 2 decimal places).
# #tax => return sum of items taxes as Float (rounded to 2 decimal places).
# #to_s => return multiline string with information about items and
#          sales tax and total.
###############################################################################
class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def total
    sum_for(:price)
  end

  def tax
    sum_for(:tax)
  end

  def to_csv
    data = items.map(&:to_s) << "\nSales Taxes: #{tax}" << "Total: #{total}"
    data.join("\n")
  end

  def add(product, quantity = 1)
    items << CartItem.new(product, quantity)
  end

  private

  def sum_for(param)
    items.map(&param).reduce(0, :+).round(2)
  end
end
