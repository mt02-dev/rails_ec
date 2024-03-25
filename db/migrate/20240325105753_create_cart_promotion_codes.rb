class CreateCartPromotionCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_promotion_codes do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :promotion_code, null: false, foreign_key: true

      t.timestamps
    end
  end
end
