require 'basket'

describe Basket do
  let(:jeans)   { double :jeans, code: 'J01', price: 32.95}
  let(:blouse)  { double :blouse, code: 'B01', price: 24.95}
  let(:socks)   { double :socks, code: 'S01', price: 7.95}
  let(:product_catalogue) {[socks, jeans, blouse]}
  # should have a list method which returns the products
  subject(:basket) { Basket.new product_catalogue}

  describe '#add' do
    it 'finds the product in the product catalogue' do
      expect(basket.add 'J01').to include jeans
    end
  end

  describe '#total' do
    it 'adds up the value of all items in the basket' do
      basket.add 'B01'
      basket.add 'S01'
      expect(basket.total).to eq 32.90
    end
  end

end
