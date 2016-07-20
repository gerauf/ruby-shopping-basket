class Basket

  def initialize product_catalogue
    @product_catalogue = product_catalogue
    @orders = []
  end

  def add product_code
    @orders << @product_catalogue.find { |product| product.code == product_code }
  end

  def total
    @orders.reduce(0){|total, order| total += order.price}
  end


end
