class CartPromotionCodesController < ApplicationController

  SUCCESS_APPLY_MESSAGE = 'Promotion code applied.'
  FAILED_APPLY_MESSAGE = 'Failed promotion code applied.'
  INVALID_PROMOTION_CODE_MESSAGE = 'Invalid promotion code.'
  ALREADY_APPLYIED_MESSAGE = 'Promotion code already applied.'
  
  def create
    redirect_to carts_path, flash: { danger: ALREADY_APPLYIED_MESSAGE } and return if already_applied?

    result = find_promotion_code(params[:promotion_code])
    if result
      cart_promotion_code = CartPromotionCode.new(cart_id: session[:cart_id], promotion_code_id: result.id)
      if cart_promotion_code.save
        flash[:success] = SUCCESS_APPLY_MESSAGE
        redirect_to carts_path
      else
        flash[:danger] = FAILED_APPLY_MESSAGE 
        redirect_to carts_path
      end
    else
      flash[:danger] = INVALID_PROMOTION_CODE_MESSAGE 
      redirect_to carts_path
    end
  end

  private

  def find_promotion_code(input_code)
    PromotionCode.find_by(code: input_code)
  end

  def already_applied?
    CartPromotionCode.find_by(cart_id: session[:cart_id])
  end


end
