RSpec.describe Cart do
  let(:products) do
    data_from_file('product_params')[0..2].map do |h|
      Product.new(h['name'], h['base_price'])
    end
  end

  let(:cart) do
    products.each.with_object(described_class.new) do |prod, cart|
      cart.add(prod)
    end
  end

  context '.new' do
    it 'can be initialized witout arguments' do
      expect { described_class.new }.not_to raise_error
    end
  end

  context '#total' do
    it 'should return Float' do
      expect(cart.total).to be_kind_of(Float)
    end

    include_examples 'correct value for', :total, data_from_file('product_params')[0..2], 29.83
    include_examples 'correct value for', :total, data_from_file('product_params')[3..4], 65.15
    include_examples 'correct value for', :total, data_from_file('product_params')[5..8], 74.63

    context 'for empty cart' do
      it 'should return 0.0' do
        expect(described_class.new.total).to eq(0.0)
      end
    end
  end

  context '#tax' do
    it 'should return Float' do
      expect(cart.tax).to be_kind_of(Float)
    end

    include_examples 'correct value for', :tax, data_from_file('product_params')[0..2], 1.50
    include_examples 'correct value for', :tax, data_from_file('product_params')[3..4], 7.65
    include_examples 'correct value for', :tax, data_from_file('product_params')[5..8], 6.65

    context 'for empty cart' do
      it 'should return 0.0' do
        expect(described_class.new.tax).to eq(0.0)
      end
    end
  end

  context '#to_csv' do
    it 'should return csv-string with cart items info, cart total and tax' do
      expect(cart.to_csv).to eq("1, book, 12.49\n"\
                              "1, music cd, 16.49\n"\
                              "1, chocolate bar, 0.85\n\n"\
                              "Sales Taxes: 1.5\n"\
                              'Total: 29.83')
    end
  end

  context '#items' do
    it 'should return Array' do
      expect(cart.items).to be_kind_of(Array)
    end

    it 'should return array of cart items' do
      expect(cart.items.all? { |i| i.class == CartItem }).to be_truthy
    end

    context 'for empty cart' do
      it 'should return empty Array' do
        expect(described_class.new.items).to eq([])
      end
    end
  end
end
