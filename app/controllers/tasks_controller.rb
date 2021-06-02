class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.order(id: :desc)
    @tasks = Task.order(expired_at: :desc) if params[:sort_expired]
    @tasks = Task.order(priority: :desc) if params[:sort_priority]

    if params[:task]
      @tasks = @tasks.search_title(params[:task][:search_title]) if params[:task][:search_title].present?
      @tasks = @tasks.search_status(params[:task][:search_status]) if params[:task][:search_status] != ""
      @tasks = @tasks.search_priority(params[:search_priority]) if params[:task][:search_priority].present?
    end

    @tasks = Kaminari.paginate_array(@tasks).page(params[:page]).per(3)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
        render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成しました"
      else
        render :new
      end
    end
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "タスクを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  def show
  end

  def edit
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
end
