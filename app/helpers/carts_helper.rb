# frozen_string_literal: true

module CartsHelper
  def total_quantity
    session[:cart_id].nil? ? 0 : Cart.find(session[:cart_id]).cart_products.sum(:quantity)
  end

  def billing_amount(_billing_amoount)
    @billing_amount.negative? ? 0 : @billing_amount
  end
end
