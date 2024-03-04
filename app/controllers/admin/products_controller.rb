# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    layout 'admin_application'
    # basic 認証
    http_basic_authenticate_with name: ENV['NAME'], password: ENV['PASSWORD']

    before_action :set_params, only: %i[show edit update destroy]
    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def show; end

    def create
      @product = Product.new(product_params)
      if @product.save
        flash[:success] = 'Success Add New Product'
        redirect_to admin_products_path
      else
        flash.now[:error] = "Couldn't add"
        render 'new', status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @product.update(product_params)
        flash[:success] = 'Success Update Product Info'
        redirect_to admin_products_path
      else
        flash.now[:error] = "Couldn't update"
        render 'edit', status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy
      flash[:success] = "#{@product.name} deleted."
      redirect_to admin_products_path, status: :see_other
    end

    private

    def product_params
      params.require(:product).permit(:name, :price, :description, :product_image)
    end

    def set_params
      @product = Product.find(params[:id])
    end
  end
end
