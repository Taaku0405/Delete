class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
  end

  def show
  end

  def edit
  end

  def unsubscribe
  end

  def withdraw
  end


  def ensure_guest_user
    @end_user = EndUser.find(params[:id])
    if @end_user.name == "guestuser"
      redirect_to end_user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
　end
end
