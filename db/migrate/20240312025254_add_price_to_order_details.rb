# frozen_string_literal: true

class AddPriceToOrderDetails < ActiveRecord::Migration[7.0]
  def change
    change_table :order_details, bulk: true do |t|
      t.column :product_name, :string
      t.column :price, :integer
    end
  end
end
