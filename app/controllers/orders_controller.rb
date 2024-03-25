# frozen_string_literal: true

class OrdersController < ApplicationController
  PURCAHSE_SUCCESS_MESSAGE = 'Thank you for your purchase!'
  PURCAHSE_ERROR_MESSAGE = "We're sorry, but the purchase was unsuccessful."

  # 購入ボタン押下時
  # cart_idをもとにCart,Cart_product テーブル削除
  # order, order_detail登録
  def create
    cart = Cart.find(session[:cart_id])
    return if cart.nil?

    cart_products = cart.cart_products.eager_load(:product)
    create_order(cart_products)
  end

  private
  
  def order_params(cart_products)
    permitted_params = billing_address_params
    permitted_params[:billing_amount] = 0
    cart_products.each do |cart_product|
      permitted_params[:billing_amount] += cart_product.product.price.to_i * cart_product.quantity.to_i
    end
    result = CartPromotionCode.find_by(cart_id: session[:cart_id])
    return unless result
    discounted_price = result.promotion_code.discounted_price
    permitted_params[:discounted_price] = discounted_price
    if permitted_params[:billing_amount] > discounted_price 
      permitted_params[:billing_amount] -= discounted_price
    else 
      permitted_params[:billing_amount] = 0
    end
    permitted_params
  end

  def billing_address_params
    params.require(:order).permit(
      :first,
      :last,
      :username,
      :email,
      :address1,
      :address2,
      :country,
      :state,
      :zip,
      :payment_methods,
      :same_address_flag,
      :save_info_flag,
      :card_number,
      :expiration,
      :card_name,
      :cvv
    )
  end

  def delete_cart
    Cart.find(session[:cart_id]).destroy
    reset_session
    flash[:success] = PURCAHSE_SUCCESS_MESSAGE
    redirect_to products_url
  end

  def order_detail_params(cart_products, order_id)
    order_details = []
    cart_products.each do |cart_product|
      order_details << {
        order_id:,
        product_id: cart_product.product_id,
        product_name: cart_product.product.name,
        price: cart_product.product.price,
        quantity: cart_product.quantity
      }
    end
    order_details
  end

  def create_order_detail(order_details)
    OrderDetail.insert_all!(order_details)
  end

  def create_order(cart_products)
    ApplicationRecord.transaction do
      order = Order.new(order_params(cart_products))
      if order.save
        create_order_detail(order_detail_params(cart_products, order.id))
        OrderMailer.send_order_detail(order).deliver_now
        delete_cart

      else
        redirect_to carts_path, status: :unprocessable_entity, flash: {
          billing_address: order,
          error_messages: order.errors.full_messages
        }
      end
    end
  rescue StandardError => e
    logger.error "An error occurred while creating the record.: #{e.message}"
    redirect_to carts_path, status: :unprocessable_entity, flash: {
      error_messages: [PURCAHSE_ERROR_MESSAGE]
    }
  end
end
