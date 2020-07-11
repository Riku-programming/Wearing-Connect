# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  # before_action :configure_sign_in_params, if: :devise_controller?




  # GET /coordinates/sign_in
  # def new
  #   super
  # end

  # POST /coordinates/sign_in
  # def create
  #   super
  # end

  # DELETE /coordinates/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
