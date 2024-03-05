class CartsController < ApplicationController
  def index; end

  def create
    product = Product.find(params[:product_id])
    session[:cart] ||= []
    session[:cart] << { product_id: product.id, quantity: params[:quantity] }
    # params[:page_info][:page] == 'show' ? redirect_to product_path(params[:main_product]) : 
    if params[:page_info][:page] == 'show'
      redirect_to product_path(params[:page_info][:main_product])
    else
      redirect_to products_path
    end

  end
end
