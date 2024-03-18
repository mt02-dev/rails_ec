class OrdersController < ApplicationController

  PURCAHSE_SUCCESS_MESSAGE = 'Thank you for your purchase!'
  PURCAHSE_ERROR_MESSAGE = 'If your purchase could not be processed, please try again later or contact customer support for assistance.'

  def show; end

  # 購入ボタン押下時
  # cart_idをもとにCart,Cart_product テーブル削除
  # order, order_detail登録
  def create
    cart = Cart.find(session[:cart_id])
    return if cart.nil?

    cart_products = cart.cart_products.eager_load(:product)

    permitted_params = set_params
    permitted_params[:billing_amount] = 0
    order_details = []
    cart_products.each do | cart_product |
      permitted_params[:billing_amount] +=  cart_product.product.price.to_i * cart_product.quantity.to_i
    end
    @order = Order.new(permitted_params)
    ApplicationRecord.transaction do
      if @order.save
        order_id = Order.find(@order.id).id
        cart_products.each do |cart_product|
          order_details << { order_id: order_id, product_id: cart_product.product_id, product_name: cart_product.product.name, price: cart_product.product.price, quantity: cart_product.quantity }
        end
        if OrderDetail.insert_all(order_details)
          Cart.find(session[:cart_id]).destroy
          reset_session
          flash[:success] = PURCAHSE_SUCCESS_MESSAGE 
          redirect_to products_url
        else
          flash.now[:danger] = PURCAHSE_ERROR_MESSAGE 
          render 'carts/index', status: :unprocessable_entity
        end
      else
        # flash.now[:danger] = order.errors.full_messages 
        flash[:billing_address] = @order
        redirect_to carts_url
      end
    end
  end
  
  private

  def set_params
    params.require(:order).permit(:first, :last, :username, :email, :address1, :address2, :country, :state, :zip, :payment_methods, :same_address_flag, :save_info_flag, :card_number, :expiration, :card_name, :cvv)
  end

  # プロモーションコード適用
  def apply_promotion_code
  end

end
