shared_examples 'correct tax calculation for' do |quantity, name, base, tax, _|
  it "should return #{tax} for '#{name}' with base price of #{base}" do
    product = Product.new(name, base)

    expect(described_class.new(product, quantity).tax).to eq(tax)
  end
end

shared_examples 'correct price calculation for' do |quantity, name, base, _, price|
  it "should return #{price} for '#{name}' with base price of #{base}" do
    product = Product.new(name, base)

    expect(described_class.new(product, quantity).price).to eq(price)
  end
end

shared_examples 'correct value for' do |type, params, value|
  key = type == :total ? :price : type
  prices = params.map { |h| h['price'] }.join(', ')

  it "should return #{value} for cart items with prices: #{prices}" do
    cart = described_class.new
    products = params.map { |h| Product.new(h['name'], h['base_price']) }
    products.each { |product| cart.add(product) }

    expect(cart.public_send(type)).to eq(value)
  end
end
