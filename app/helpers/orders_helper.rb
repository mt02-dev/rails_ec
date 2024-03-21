# frozen_string_literal: true

module OrdersHelper
  def date_format(date)
    date.strftime("%Y/%m/%d")
  end
end
