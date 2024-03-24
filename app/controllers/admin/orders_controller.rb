# frozen_string_literal: true

module Admin
  class OrdersController < ApplicationController
    layout 'admin_application'
    http_basic_authenticate_with name: ENV['NAME'], password: ENV['PASSWORD']

    def index
      @orders = Order.all
    end

    def show
      @order = Order.find(params[:id])
    end
  end
end
