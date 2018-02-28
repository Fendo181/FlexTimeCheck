class UsersController < ApplicationController
  def home
    @user = User.new
  end

  def check
    # 入力値のチェック
    @user = User.new(user_params)
    if @user.valid?
      # OK。確認画面を表示
      id = @user.id
      password = @user.password

      

      render 'help'
    else
      # NG。入力画面を再表示
      render 'home'
    end
  end

  def help
  end

  def hm(mins, display_sign: false)
    sign = mins <=> 0
    mins = mins.abs

    hours, mins = mins.divmod(60)
    (display_sign ? (sign >= 0 ? '+' : '-') : '') + (hours > 0 ? "#{hours}h" : '') + "#{mins}m"
  end

  private
    def user_params
      params.require(:user).permit(:id, :password)
    end
end
