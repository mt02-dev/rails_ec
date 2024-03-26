# frozen_string_literal: true

class AddUsedAtToPromotionCodes < ActiveRecord::Migration[7.0]
  def change
    add_column :promotion_codes, :used_at, :datetime
  end
end
