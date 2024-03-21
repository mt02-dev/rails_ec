# Preview all emails at http://localhost:3000/rails/mailers/order
class OrderPreview < ActionMailer::Preview

  def send_order_detail
    OrderMailer.send_order_detail(Order.first)
  end


end
