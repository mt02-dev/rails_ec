class AddDiscountedPriceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :discounted_price, :integer
  end
end
