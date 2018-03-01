class UsersController < ApplicationController
  def home
    @user = User.new
  end

  def check
    # 入力値のチェック
    @user = User.new(user_params)
    if @user.valid?
      calculate_time(@user.id, @user.password)
      render 'home'
    else
      # NG。入力画面を再表示
      render 'home'
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :password)
    end
end
