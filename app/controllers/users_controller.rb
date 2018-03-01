class UsersController < ApplicationController
  def home
    @user = User.new
  end

  def check
    # 入力値のチェック
    @user = User.new(user_params)
    if @user.valid?
      check_kintai(@user.id, @user.password)
      render 'help'
    else
      # NG。入力画面を再表示
      render 'home'
    end
  end

  def help
  end

  private
    def user_params
      params.require(:user).permit(:id, :password)
    end
end
