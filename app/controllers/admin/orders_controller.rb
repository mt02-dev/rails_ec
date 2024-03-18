class OrdersController << ApplicationController
  http_basic_authenticate_with name: ENV['NAME'], password: ENV['PASSWORD'], only: %i[index, show]
  def index; end
  end

  def show; end


end