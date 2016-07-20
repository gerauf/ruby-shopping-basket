require 'basket'

describe Basket do
  let(:jeans)             { double :jeans, code: 'J01', price: 32.95}
  let(:blouse)            { double :blouse, code: 'B01', price: 24.95}
  let(:socks)             { double :socks, code: 'S01', price: 7.95}
  let(:product_catalogue) { double :product_catalogue}
  let(:offers)            { double :offers }
  let(:shipping)          { double :shipping }
  subject(:basket)        { Basket.new product_catalogue, offers, shipping}

  # assumptions

  # Products, ProductCatalogue, Offers and Shipping are all classes worked on by
  # the rest of the team

  # Products have a code and a price

  # ProductCatalogue has an interface which looks up a product code and returns the
  # correct product

  # Offers has an interface which takes the current basket and calculates any offers
  # based on its own implementation

  # Shipping has an interface which takes the total basket value (after offers are
  # applied) and calulates shippng fee based on its own internal implementation

  # For this test I have ignorred the internal implementations of the other classes
  # and solely focused on the basket class and its interfaces, stubbing, mocking and
  # spying on the other classes where neccessary

  describe '#add' do
    it 'looks up the product in the product catalogue' do
      allow(product_catalogue).to receive(:look_up).with(jeans.code)

      basket.add jeans.code

      expect(product_catalogue).to have_received(:look_up).with(jeans.code)
    end

    it 'looked up products are added to the basket' do
      mock_look_up_product jeans
      expect(basket.add jeans.code).to include jeans
    end
  end

  describe '#total' do
    it 'adds up the value of all items in the basket' do
      mock_look_up_product blouse
      mock_look_up_product socks
      stub_shipping
      stub_offers
      basket.add blouse.code
      basket.add socks.code
      expect(basket.total).to eq (blouse.price + socks.price)
    end

    it 'calculates any offers' do
      mock_look_up_product jeans
      stub_shipping
      offer = -32.95
      allow(offers).to receive(:calculate).with([jeans, jeans]).and_return(offer)
      2.times { basket.add jeans.code }
      expect(basket.total).to eq (2* jeans.price + offer)
    end

    it 'calculates shipping' do
      mock_look_up_product blouse
      mock_look_up_product socks
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

  def mock_look_up_product product
    allow(product_catalogue)
      .to receive(:look_up).with(product.code)
      .and_return(product)
  end

end
