class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def new
    if logged_in?
      redirect_to user_path(current_user.id)
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

  def show
    @user = User.find(params[:id])
    # @task = Task.all
    @tasks = current_user.tasks
    # if @user.id != current_user.id
    #   redirect_to tasks_path
    # end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:admin,:name, :email, :password, :password_confirmation)
  end
end
