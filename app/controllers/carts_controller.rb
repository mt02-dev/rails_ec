# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    product_id_and_quantity = CartProduct.where(cart_id: session[:cart_id]).group(:product_id).sum(:quantity)

    @cart = { products: [], total:  0 }
    product_id_and_quantity.each do |product_id, quantity|
      product = Product.find(product_id)
      @cart[:total] += product.price * quantity
      @cart[:products] << { product:, quantity: }
    end
    @cart
  end

  def new; end

  def create
    create_cart if session[:cart_id].nil?

    # add_to_cartボタンが押されたオブジェクトを検索
    product = Product.find(params[:product_id])
    cart_item = CartProduct.new(cart_id: session[:cart_id], product_id: product.id, quantity: params[:quantity])
    if cart_item.save
      params[:flag] == 'main' ? specify_destination(product) : specify_destination(params[:main_product])
    else
      flash[:danger] = "Couldn't add in cart."
    end
  end

  def destroy
    CartProduct.where(cart_id: session[:cart_id]).where(product_id: params[:target]).destroy_all
    redirect_to carts_path status: :see_other
  end

  private

  def create_cart
    cart = Cart.create!
    session[:cart_id] = cart.id
  end

  def specify_destination(product)
    if params[:location] == 'show'
      redirect_to product_url(product)
    else
      redirect_to products_url
    end
  end
end
