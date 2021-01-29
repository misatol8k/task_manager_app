class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user_required, only: [:show, :edit]

  def new
    if logged_in?
      redirect_to user_path(current_user.id), notice: "このページは表示できません"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @user.update(user_params)
      render :show, notice: "更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to new_session_path, notice: '削除しました！'
  end

  def set_user
    @user = User.find(params[:id])
  end

  def current_user_required
    unless current_user.id == @user.id
      redirect_to tasks_url, notice: "このページは表示できません"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :id)
  end
end
