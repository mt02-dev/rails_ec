class OrdersController < ApplicationController
  http_basic_authenticate_with name: ENV["NAME"], password: ["PASSWORD"], only: %i[index show]
  def index

  end

  def show
  end

  def create
  end
end
