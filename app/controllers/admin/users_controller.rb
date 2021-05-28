class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user,only: [:edit,:update,:destroy, :show]
  before_action :not_admin
  def index
    @users = User.select(:id,:name,:email)
  end

  def show
    @task = @user.tasks
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path notice: '新たな管理者が誕生しました'
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: '管理者を排除しました'
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: '管理者を更新しました'
    else
      render :edit
    end
  end

  def edit
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def not_admin
    redirect_to user_path(current_user.id), notice:"管理画面へは、管理者以外はアクセスできません"   unless current_user.admin == '管理者'
  end

  def user_params
    params.require(:user).premit(:admin,:name,:email,:password,:password_confirmation)
  end
end
