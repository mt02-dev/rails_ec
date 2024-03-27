# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  has_many :cart_promotion_codes, dependent: :destroy

  def used_promotion_code
    update_attribute(:used_at, Time.zone.now)
  end
end
