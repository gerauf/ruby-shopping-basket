class Basket

  def initialize product_catalogue, offers, shipping
    @product_catalogue = product_catalogue
    @offers = offers
    @shipping = shipping
    @orders = []
  end

  def add product_code
    @orders << @product_catalogue.find { |product| product.code == product_code }
  end

  def total
    total = 0
    total += @orders.reduce(0){|total, order| total += order.price}
    total += @offers.calculate(@orders)
    total += @shipping.calculate(total)
  end


end
