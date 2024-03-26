# frozen_string_literal: true

class CartPromotionCode < ApplicationRecord
  belongs_to :cart
  belongs_to :promotion_code
end
