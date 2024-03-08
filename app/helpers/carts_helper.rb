# frozen_string_literal: true

module CartsHelper
  def cart_products(cart_id)
    return 0 if cart_id.nil?

    CartProduct.where(cart_id:).sum(:quantity)
  end
end
