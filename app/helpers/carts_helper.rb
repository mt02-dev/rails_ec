module CartsHelper

  def total_quantity
    sum = 0
    session[:cart].each do |cart_product|
      sum += cart_product["quantity"].to_i
    end
    sum
  end

  def cart_products
    session[:cart].nil? ? 0 : total_quantity
  end

  def product_name(product_id)
    Product.find(product_id).name
  end

  def product_price(product_id)
    Product.find(product_id).price
  end

  def total_for_each
    id_and_quantity_hash = session[:cart].group_by { |one_record| one_record["product_id"] }.transform_values { |v| v.sum { |h| h["quantity"].to_i}}
    id_and_quantity_hash.map { |k, v| { product_id: k, quantity: v } }
  end

  def delete_target(product_id)
    session[:delete_target] = product_id
  end

  def total_amount
    total = 0
    id_and_quantity_hash = total_for_each
    id_and_quantity_hash.each do |product|
      price = Product.find(product[:product_id]).price
      total += price * product[:quantity]
    end
    total
  end
end

