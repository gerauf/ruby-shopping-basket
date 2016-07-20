require 'basket'

describe Basket do
  let(:jeans)   { double :jeans, code: 'J01', price: 32.95}
  let(:blouse)  { double :blouse, code: 'B01', price: 24.95}
  let(:socks)   { double :socks, code: 'S01', price: 7.95}
  let(:product_catalogue) {[socks, jeans, blouse]}
  let(:offers)   { double :offers }
  # should have a list method which returns the products
  subject(:basket) { Basket.new product_catalogue, offers}

  describe '#add' do
    it 'finds the product in the product catalogue' do
      expect(basket.add jeans.code).to include jeans
    end
  end

  describe '#total' do
    it 'adds up the value of all items in the basket' do
      allow(offers).to receive(:calculate).and_return(0)
      basket.add blouse.code
      basket.add socks.code
      expect(basket.total).to eq 32.90
    end

    it 'calculates any offers' do
      allow(offers).to receive(:calculate).with([jeans, jeans]).and_return(-32.95)
      2.times { basket.add jeans.code }
      expect(basket.total).to eq 32.95
    end

  end

end
