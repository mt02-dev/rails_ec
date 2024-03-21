class OrderMailer < ApplicationMailer
  default from: ENV['EMAIL']
  # 仮の引数定義
  # email とnameが必要かと思われ
  def send_order_detail(order)
    return if order.email.nil?
    @order = order
    mail(to: ENV['EMAIL'], subject: 'Purchase detail') 
  end
end
