# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :product_image
end
