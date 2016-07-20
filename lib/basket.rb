class Basket

  def initialize product_catalogue
    @product_catalogue = product_catalogue
  end

  def add product_code
    @product_catalogue.find { |product| product.code == product_code }
  end

end
