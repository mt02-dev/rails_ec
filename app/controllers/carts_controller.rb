# frozen_string_literal: true

class CartsController < ApplicationController
  def index; end

  def create
    product = Product.find(params[:product_id])
    session[:cart] ||= []
    session[:cart] << { product_id: product.id, quantity: params[:quantity] }
    if params[:page_info][:page] == 'show'
      redirect_to product_path(params[:page_info][:main_product])
    else
      redirect_to products_path
    end
  end

  def destroy
    remove_id = session[:delete_target]
    session[:cart].reject! { |one_record| one_record['product_id'] == remove_id }
    session[:delete_target] = nil
    redirect_to carts_url :see_other
  end
end
