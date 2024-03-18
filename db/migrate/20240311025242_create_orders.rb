class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :first, null: false
      t.string :last, null: false
      t.string :username, null: false
      t.string :email
      t.string :address1, null: false
      t.string :address2
      t.string :country, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :billing_amount, null: false
      t.integer :payment_methods, null: false
      t.boolean :same_address_flag, defalut: false
      t.boolean :save_info_flag, defalut: false
      t.string :card_number, null: false
      t.string :expiration, null: false
      t.string :card_name, null: false
      t.string :cvv, null: false

      t.timestamps
    end
  end
end
