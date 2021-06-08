class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @tasks = Task.all.order(params[:sort_expired])
    if params[:sort_expired]
      @tasks = Kaminari.paginate_array(Task.all.order(endtime_at: :desc)).page(params[:page]).per(3)  
      
    elsif params[:sort_priority] 
      @tasks = Kaminari.paginate_array(current_user.tasks.order(priority: :desc)).page(params[:page]).per(3)
      
    elsif params[:search]
      if params[:search_title].present? && params[:search_status].present?
        @tasks = Kaminari.paginate_array(current_user.tasks.search_title(params[:search_title]).search_status(params[:search_status])).page(params[:page]).per(3)
        
      elsif params[:search_title].present?
        @tasks = Kaminari.paginate_array(current_user.tasks.search_title(params[:search_title])).page(params[:page]).per(3)
        
      elsif params[:search_status].present?
        @tasks = Kaminari.paginate_array(current_user.tasks.search_status(params[:search_status])).page(params[:page]).per(3)
        
      elsif params[:search_priority].present?
        # binding.irb
        @tasks = Kaminari.paginate_array(current_user.tasks.search_priority(params[:search_priority])).page(params[:page]).per(3)
      elsif params[:search_label].present?
        # binding.irb
        @tasks = Kaminari.paginate_array(current_user.tasks.search_label(params[:search_label])).page(params[:page]).per(3)
        
      else
        @tasks = Kaminari.paginate_array(current_user.tasks.order(id: :desc)).page(params[:page]).per(3)
        # @tasks << @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
      end
      
    else
      @tasks = Kaminari.paginate_array(current_user.tasks.order(id: :desc)).page(params[:page]).per(3)
      # @labels = Label.all
    end
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
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority, :user_id,:user_id, {label_ids: [] })
  end
end
