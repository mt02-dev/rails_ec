# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :product_image
  has_many :cart_products, dependent: :destroy
  has_many :order_details, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
end
