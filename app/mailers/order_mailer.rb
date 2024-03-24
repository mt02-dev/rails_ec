# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  helper OrdersHelper
  def send_order_detail(order)
    return if order.email.nil?

    @order = order
    mail(to: order.email, subject: 'Purchase detail')
  end
end
