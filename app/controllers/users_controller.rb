class UsersController < ApplicationController
  def index
    @user = User.new
  end

  def check
    # 入力値のチェック
    @user = User.new(user_params)
    if @user.valid?
      begin
        calculate_time(@user.id, @user.password)
      rescue
        @error_msg = '惜しい！勤之助のログインに失敗しました！ もう一度お試し下さい。'
      end
      render 'index'
    else
      # NG。入力画面を再表示
      render 'index'
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :password)
    end
end
