class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    if @user.save
      redirect_to admin_users_path notice: '新たな管理者が誕生しました'
    else
      render :new
    end
  end

  def destroy
  end

  def update
  end

  private
  def user_params
    params.require(:user).premit(:name,:email,:password,:password_confirmation)
  end
end
