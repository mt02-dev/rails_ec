# frozen_string_literal: true

module OrdersHelper
  def date_format(date)
    date.strftime('%Y/%m/%d')
  end

  def payment_methods_display(num)
    case num
    when 1
      'Credit Card'
    when 2
      'Debit card'
    when 3
      'PayPal'
    end
  end
end
