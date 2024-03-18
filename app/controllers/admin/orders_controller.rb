module
  class OrdersController < ApplicationController
    http_basic_authenticate_with name: ENV['NAME'], password: ENV['PASSWORD'], only: %i[index, show]
    def index; end

    def show; end
  end
end
