class CartsController < ApplicationController

  def index; end
  
  def new; end
  
  def create
    # この状態だと別のカートが作れない 異なるブラウザ間でカート共有している状態
    create_cart if session[:cart_id].nil?
    @product = Product.find(params[:product_id])
    cart_item = CartProduct.new(cart_id: session[:cart_id], product_id: @product.id,quantity: params[:quantity])
    if cart_item.save
      specify_destination(@product)
    else
      flash[:danger] = "Couldn't add in cart."
    end
  end
    

  private
  
  def create_cart 
    cart = Cart.create!
    session[:cart_id] = cart.id
  end

  def specify_destination(product)
    if session[:location] == 'show'
    else 
      render product_url(product)
    end
  end

end
