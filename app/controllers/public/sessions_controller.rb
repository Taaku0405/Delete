# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  #サインインする前にend_user_stateを実行する
  before_action :end_user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

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
  protected
  #会員情報を確認するためのコマンド
  def end_user_state
    ## 【処理内容1】入力されたemailからアカウントを1件取得
     @end_user = EndUser.find_by(email: params[:end_user][:email])
    ## 【アカウントを取得できなかった場合、このメソッドを終了
    return if !@end_user
    ## 【処理内容2】取得したアカウントのパスワードと入力されたパスワードが一致しているかを判別
    if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == true)
      flash[:notice] = "退会済みです。お手数ですが、再度ご登録をしてご利用してください。"
      redirect_to new_end_user_registration_path
    end
  end

  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    redirect_to end_users_path(end_user), notice: "ゲストユーザーでログインしました"
  end
  
end
