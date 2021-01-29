module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def login_required
    redirect_to new_session_path, notice: "ログインしてください" unless current_user
    end
  end
