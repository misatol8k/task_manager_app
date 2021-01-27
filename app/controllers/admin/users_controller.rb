class Admin::UsersController < ApplicationController
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
    @users = User.selected.order(created_at: :desc)
  end

  def edit
  end

  def show
    @tasks = @user.tasks.selected.page(params[:page])
  end

  def update
    if @user.update(user_params)
      render :show, notice: "ユーザー「#{@user.name}」を更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to new_session_path, notice: "ユーザー「#{@user.name}」を削除しました！"
  end

  def set_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :id)
  end
end
