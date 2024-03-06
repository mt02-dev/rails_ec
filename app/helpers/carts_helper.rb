module CartsHelper
  def cart_products
    CartProduct.count
  end
end
