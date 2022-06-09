class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @end_user = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = current_end_user
  end

  def update
    @end_user = current_end_user
    if @end_user.update(end_user_params)
      redirect_to end_user_path, notice: "会員情報を更新しました"
    else
      render :edit
    end
  end

  def unsubscribe
    @end_user = current_end_user
  end

  def withdraw
    @end_user = current_end_user
    #会員のis_deletedにtrueを入れて更新した時(退会しなかった時)
    @end_user.update(deleted_flag: true)
    #ログイン情報をリセットした時(退会した時)
    reset_session
    redirect_to root_path
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image, :email)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
