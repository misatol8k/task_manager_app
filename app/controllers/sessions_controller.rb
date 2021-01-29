class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      # ログイン成功した場合
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      # ログイン失敗した場合
      flash.now[:notice] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    # ログアウトの処理
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
