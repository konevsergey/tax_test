#!/usr/bin/env ruby
require 'bundler/setup'
Bundler.require

require './spec/helpers'

Dir["#{File.expand_path(File.dirname(__FILE__))}/lib/*.rb"].each do |file|
  require file
end

io = Class.new { include Helpers }
params = io.data_from_file('product_params')

products = params.map do |h|
  Product.new(h['name'], h['base_price'])
end

inputs = [products[0..2], products[3..4], products[5..8]]

inputs.each.with_index(1) do |data, i|
  cart = data.each.with_object(Cart.new) do |product, c|
    c.add(product)
  end

  io.export_to(cart.to_csv, "cart#{i}.csv")
end
