# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  has_many :cart_promotion_codes, dependent: :destroy
end
