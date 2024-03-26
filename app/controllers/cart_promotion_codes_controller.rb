# frozen_string_literal: true

class CartPromotionCodesController < ApplicationController
  SUCCESS_APPLY_MESSAGE = 'Promotion code applied.'
  FAILED_APPLY_MESSAGE = 'Failed promotion code applied.'
  USED_PROMOTION_CODE_MESSAGE = 'This promotion code is already used.'
  INVALID_PROMOTION_CODE_MESSAGE = 'Invalid promotion code.'
  ALREADY_APPLYIED_MESSAGE = 'Promotion code already applied.'

  def create
    return if params[:promotion_code].blank?
    redirect_to carts_path, flash: { danger: USED_PROMOTION_CODE_MESSAGE } and return if used_promotion_code?
    redirect_to carts_path, flash: { danger: ALREADY_APPLYIED_MESSAGE } and return if already_applied?

    result = find_promotion_code(params[:promotion_code])
    code_status_check(result)
    redirect_to carts_path
  end

  private

  def code_status_check(promotion_code)
    if promotion_code
      cart_promotion_code = CartPromotionCode.new(cart_id: session[:cart_id], promotion_code_id: promotion_code.id)
      if cart_promotion_code.save
        flash[:success] = SUCCESS_APPLY_MESSAGE
      else
        flash[:danger] = FAILED_APPLY_MESSAGE
      end
    else
      flash[:danger] = INVALID_PROMOTION_CODE_MESSAGE
    end
  end

  def find_promotion_code(input_code)
    PromotionCode.find_by(code: input_code)
  end

  def already_applied?
    CartPromotionCode.find_by(cart_id: session[:cart_id])
  end

  def used_promotion_code?
    PromotionCode.find_by(code: params[:promotion_code])&.used_at
  end
end
