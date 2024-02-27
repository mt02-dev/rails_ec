# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    debugger
    @product = Product.find(params[:id])
    @related_products = Product.order(:created_at).limit(4)
  end
end
