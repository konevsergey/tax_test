RSpec.describe CartItem do
  let(:product) { Product.new('book', 12.49) }
  let(:cart_item) { described_class.new(product, 1) }

  context '.new' do
    it 'should not be initialized witout arguments' do
      expect { described_class.new }.to raise_error(ArgumentError, /given 0, expected 2/)
    end
  end

  context '#tax' do
    it 'should return Float' do
      expect(cart_item.tax).to be_kind_of(Float)
    end

    data_from_file('product_params').each do |prod|
      include_examples 'correct tax calculation for', prod.values
    end
  end

  context '#price' do
    it 'should return Float' do
      expect(cart_item.price).to be_kind_of(Float)
    end

    data_from_file('product_params').each do |prod|
      include_examples 'correct price calculation for', prod.values
    end
  end

  context '#to_s' do
    it 'should return string with name and price of the product' do
      expect(cart_item.to_s).to eq('1, book, 12.49')
    end
  end

  context '#product' do
    it 'should return product instance' do
      expect(cart_item.product).to eq(product)
    end
  end

  context '#name' do
    it 'should return name of product' do
      expect(cart_item.name).to eq(product.name)
    end
  end
end
