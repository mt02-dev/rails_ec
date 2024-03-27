# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart

  ADD_CART_ERROR_MESSAGE = "Couldn't add in cart."

  def index
    @order = Order.new(flash[:billing_address])
    @cart_products = @cart.cart_products.eager_load(:product)
    @total_quantity = @cart_products.sum(:quantity)
    @billing_amount = 0
    @cart_products.each do |cart_product|
      @billing_amount += cart_product.product.price * cart_product.quantity
    end
    result = promotion_code_applied?
    return unless result

    @discounted_price = result.promotion_code.discounted_price
    @promotion_code = result.promotion_code.code
    @billing_amount -= @discounted_price
  end

  def new; end

  def create
    # add_to_cartボタンが押されたオブジェクトを検索
    product = @cart.cart_products.find_by(product_id: params[:product_id])
    if product
      quantity = product.quantity.to_i + params[:quantity].to_i
      if product.update(quantity:)
        redirect_to products_url
      else
        flash[:danger] = ADD_CART_ERROR_MESSAGE
      end
    else
      cart_item = CartProduct.new(cart_id: session[:cart_id], product_id: params[:product_id],
                                  quantity: params[:quantity])
      if cart_item.save
        redirect_to products_url
      else
        flash[:danger] = ADD_CART_ERROR_MESSAGE
      end
    end
  end

  def destroy
    @cart.cart_products.where(product_id: params[:product_id]).destroy_all
    redirect_to carts_path status: :see_other
  end

  private

  def set_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def find_promotion_code(input_code)
    PromotionCode.find_by(code: input_code)
  end

  def promotion_code_applied?
    CartPromotionCode.find_by(cart_id: session[:cart_id])
  end
end
