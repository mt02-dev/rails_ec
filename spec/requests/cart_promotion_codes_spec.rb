# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CartPromotionCodes', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/cart_promotion_codes/create'
      expect(response).to have_http_status(:success)
    end
  end
end
