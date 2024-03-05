module CartsHelper
  def cart_items
    session[:cart].nil? ? 0 : session[:cart].count
  end
end
