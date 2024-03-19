# frozen_string_literal: true

class ChangeColumnsInOrderDetails < ActiveRecord::Migration[7.0]
  def change
    change_table :order_details do
      change_column_null :order_details, :quantity, false
      change_column_null :order_details, :product_name, false
      change_column_null :order_details, :price, false
    end
  end
end
