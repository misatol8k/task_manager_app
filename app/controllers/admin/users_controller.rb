class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id), notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def index
    @users = User.all.includes(:tasks)
  end

  def edit
  end

  def show
    @tasks = @user.tasks.selected.page(params[:page])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を更新しました！"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました！"
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :id)
  end

  def require_admin
    redirect_to tasks_url, notice: "管理者以外はアクセスできません" unless current_user.admin?
  end
end
