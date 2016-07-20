require 'basket'

describe Basket do
  let(:jeans)             { double :jeans, code: 'J01', price: 32.95}
  let(:blouse)            { double :blouse, code: 'B01', price: 24.95}
  let(:socks)             { double :socks, code: 'S01', price: 7.95}
  let(:product_catalogue) {[socks, jeans, blouse]}
  let(:offers)            { double :offers }
  let(:shipping)          { double :shipping }
  # should have a list method which returns the products
  subject(:basket) { Basket.new product_catalogue, offers, shipping}

  describe '#add' do
    it 'finds the product in the product catalogue' do
      expect(basket.add jeans.code).to include jeans
    end
  end

  describe '#total' do
    it 'adds up the value of all items in the basket' do
      stub_shipping
      stub_offers
      basket.add blouse.code
      basket.add socks.code
      expect(basket.total).to eq 32.90
    end

    it 'calculates any offers' do
      stub_shipping
      allow(offers).to receive(:calculate).with([jeans, jeans]).and_return(-32.95)
      2.times { basket.add jeans.code }
      expect(basket.total).to eq 32.95
    end

    it 'calculates shipping' do
      stub_offers
      shipping_fee = 4.95
      allow(shipping)
        .to receive(:calculate)
        .with(socks.price + blouse.price)
        .and_return(shipping_fee)

      basket.add blouse.code
      basket.add socks.code

      expect(basket.total).to eq (socks.price + blouse.price + shipping_fee)
    end
  end

  def stub_shipping
    allow(shipping).to receive(:calculate).and_return(0)
  end

  def stub_offers
    allow(offers).to receive(:calculate).and_return(0)
  end

end
