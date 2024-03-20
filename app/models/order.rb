# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy

  validates :first, :last, :username, :address1, :country, :state, :zip, :card_name, :card_number, :cvv, presence: true
  validates :expiration, presence: true, format: { with: /\A\d{4}\z/ }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
end
