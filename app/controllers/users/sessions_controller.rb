# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストとしてログインしました。'
  end

  def create
    # request.env['omniauth.auth']にユーザのTwitter認証情報が格納されている
    if user_data = request.env['omniauth.auth']
      session[:nickname] = user_data[:info][:nickname]
      redirect_to root_path, notice: 'ログインしました'
    end
    super
  end


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
